;; compiling.el --- utilities concerned with compiling
;; Copyright (C) 2015-2017  Dan Harms (dharms)
;; Author: Dan Harms <danielrharms@gmail.com>
;; Created: Saturday, February 28, 2015
;; Version: 1.0
;; Modified Time-stamp: <2017-05-26 17:48:33 dharms>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'dash)

;; automatically scroll compilation window
(setq compilation-scroll-output t)

(defun my/compilation-mode-hook()
  (setq truncate-lines nil) ; is buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil))
(add-hook 'compilation-mode-hook 'my/compilation-mode-hook)

(defun my/check-compile-buffer-cmake-werror ()
  "Ignores the compile line `-Werror' that cmake echoes."
  (save-match-data
    (looking-back "-W" (- (point) 2))))
(defun my/check-compile-buffer-boost-test-output ()
  "Ignores the BOOST test output `No errors detected'."
  (and
   (save-match-data
     (looking-back "[Nn]o " (- (point) 3)))
   (save-match-data
     (looking-at "errors detected"))))

(defvar my/ignore-compile-error-functions
  `(my/check-compile-buffer-cmake-werror
    my/check-compile-buffer-boost-test-output
    )
  "List of functions to filter compile errors.
If any return true, the current error is ignored."
  )

(defun check-compile-buffer-errors(buffer)
  "Check the current buffer for compile warnings or errors."
  (with-current-buffer buffer
    (catch 'found
      (goto-char 1)
      (while (search-forward-regexp "\\([Ww]arning\\|[Ee]rror\\)" nil t)
        (goto-char (match-beginning 1))
        (unless
            (-any 'funcall my/ignore-compile-error-functions)
          (throw 'found t))
        (goto-char (match-end 1)))
      nil)))

(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if it succeeded without warnings or errors."
  (if (and
       (string-match "compilation" (buffer-name buffer))
       (string-match "finished" string)
       (not (check-compile-buffer-errors buffer)))
      (run-with-timer 2 nil
                      (lambda (buf)
                        (let ((win (get-buffer-window buf t)))
                          (bury-buffer buf)
                          (if should-close-compilation-window
                              (delete-window win)
                            (switch-to-prev-buffer win 'kill))))
                      buffer)))

(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

;; compiling.el ends here
