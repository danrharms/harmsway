;; custom-utils.el --- misc. utilities
;; Copyright (C) 2015, 2016  Dan Harms (dharms)
;; Author: Dan Harms <danielrharms@gmail.com>
;; Created: Saturday, February 28, 2015
;; Version: 1.0
;; Modified Time-stamp: <2016-12-09 17:51:07 dharms>
;; Modified by: Dan Harms
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

(require 'popup-imenu)

(defun insert-now()
  "Insert string for current time formatted like `2:34 PM'."
  (interactive)
  (insert (now)))
(defun now()
  "Return string for current time formatted like `2:34 PM'."
  (interactive)
  (format-time-string "%D %-I:%M %p"))

(defun insert-today()
  "Insert string for today's date nicely formatted in American style,
  e.g. Sunday, September 17, 2000."
  (interactive)
  (insert (today)))
(defun today()
  "Return string for today's date nicely formatted in American style,
  e.g. Sunday, September 17, 2000."
  (interactive)
  (format-time-string "%A, %B %e, %Y"))

(defun sanityinc/eval-last-sexp-or-region (prefix)
  "Eval region from BEG to END if active, otherwise the last sexp."
  (interactive "P")
  (if (and (mark) (use-region-p))
      (eval-region (min (point) (mark)) (max (point) (mark)))
    (pp-eval-last-sexp prefix)))

;; todo: deprecate
(defun find-file-upwards (dir file-to-find)
  "Recursively search upward for file; returns path to file or nil if not found."
  (interactive)
  (let*
      ((find-file-r
        (lambda (path)
          (let* ((parent (file-name-directory path))
                 files)
            (cond
             ((or (null parent) (equal parent (directory-file-name parent))) nil)
             ((setq files (directory-files parent t file-to-find))
              (car files))              ;found
             ;; parent of ~ is nil, parent of / is itself
             ;; This terminating condition accounts for both
             (t (funcall find-file-r
                         (directory-file-name parent))))))))
    (funcall find-file-r (or dir default-directory))))

;; todo: deprecate
(defun find-file-dir-upwards (file-to-find)
  "Recursively search upward for file; returns file's directory or nil if not found."
  (interactive)
  (let ((file (find-file-upwards file-to-find)))
    (if file (file-name-directory file) nil)))

(defun goto-line-with-feedback()
  "Show line numbers temporarily while prompting for the target line."
  (interactive)
  (if (and (or (not (boundp 'linum-mode)) (not linum-mode))
           (not current-prefix-arg))
      (unwind-protect
          (progn
            (linum-mode 1)
            (call-interactively 'goto-line))
        (linum-mode -1))
    (call-interactively 'goto-line)))
(global-set-key [remap goto-line] 'goto-line-with-feedback)

;; from Marcin Borkowski
(defun find-function-view (func)
  "Find and view the definition of FUNC."
  (interactive (find-function-read))
  (find-function-do-it func nil 'switch-to-buffer)
  (view-mode 1))

;; (defvar my/find-file-root-prefix "/sudo::"
;;   "root prefix for tramp as root")

;; (defun my/find-file-as-root()
;;   "Open a file for editing by root."
;;   (interactive)
;;   (let ((root-prefix my/find-file-root-prefix))
;;     (call-interactively 'find-file)))
;; (global-set-key "\esrf" 'my/find-file-as-root)

;; (defun my/find-current-file-as-root()
;;   "Open the current file for editing by root."
;;   (interactive)
;;   (set-visited-file-name (concat my/find-file-root-prefix
;;                                  (buffer-file-name)))
;;   (setq buffer-read-only nil))
;; (global-set-key "\esrr" 'my/find-current-file-as-root)

(defun shell-command-redirected-output (cmd)
  "Run a shell command, with the option of separately redirecting
stdout and stderr. Use instead of `shell-command-to-string'.
Substitute the `nil' in '(t nil)' with a filename to redirect
stderr into that file."
  (interactive "sCmd: ")
  (with-output-to-string
    (with-current-buffer standard-output
      (process-file shell-file-name nil
                    '(t nil) nil
                    shell-command-switch
                    cmd))))

(provide 'custom-utils)
;; utils.el ends here
