;;; custom-coding.el --- custom coding utilities
;; Copyright (C) 2016-2017  Dan Harms (dharms)
;; Author: Dan Harms <danielrharms@gmail.com>
;; Created: Tuesday, April 12, 2016
;; Version: 1.0
;; Modified Time-stamp: <2017-06-20 08:40:25 dharms>
;; Modified by: Dan Harms
;; Keywords: coding

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
(require 's)

(defun print-current-function() "Print current function under point."
  (interactive)
  (message (which-function)))

;; include ifdefs
(defvar site-name nil "A possibly empty name of the current site.")
(defun add-header-include-ifdefs (&optional arg)
  "Add header include guards.
With optional prefix argument ARG, query for the base
name.  Otherwise, the base file name is used."
  (interactive "P")
  (let* ((name (if (buffer-file-name)
                   (file-name-nondirectory (buffer-file-name))
                 (buffer-name)))
         (project-name (proviso-current-project-name))
         (str
          (replace-regexp-in-string
           "\\.\\|-" "_"
           name)))
    (if (fboundp 's-snake-case)
        (setq str (upcase (s-snake-case str)))
      (setq str (upcase str)))
    (save-excursion
      (if arg                           ;ask user for stem
          (setq str (concat
                     (read-string "Include guard stem: " nil nil str) "_H"))
        ;; no arg; if project-name or site-name are defined, prepend them
        (when project-name
          (setq str (concat project-name "_" str))))
        (when site-name
          (setq str (concat site-name "_" str)))
      (setq str (upcase (concat "__" str "__")))
      (goto-char (point-min))
      (insert "#ifndef " str "\n#define " str "\n\n")
      (goto-char (point-max))
      (insert "\n#endif")
      (insert-char ?\s c-basic-offset)
      (insert "/* #ifndef " str " */\n")
      )))

;; class header
(defun insert-class-header (&optional arg)
  "Insert a formatted class header given the current selection or position."
  (interactive "P")
  (let ((str
         (if (region-active-p)
             (buffer-substring-no-properties (region-beginning)(region-end))
           (thing-at-point 'symbol)))
        (i 0) len)
    (if (or arg (= 0 (length str)))
        (setq str (read-string "Enter the title symbol: ")))
                                        ; (message "symbol %s is %d chars long" str (length str))(read-char)
    (c-beginning-of-defun)
    (move-beginning-of-line nil)
    (insert "//")
    (insert-char ?- (- fill-column 2))
    (insert "\n")
    (insert "//---- " str " ")
    (setq len (- (- fill-column 8) (length str)))
    (while (< i len)
      (insert "-")
      (setq i (1+ i)))
    (insert "\n//")
    (insert-char ?- (- fill-column 2))
    (insert "\n")
    ))

;; casting
(defvar my/cast-history-list nil)
(defun insert-cast (start end)
  "Insert code for a cast around a region."
  (interactive "r")
  (let ((initial (if my/cast-history-list
                     (car my/cast-history-list)
                   "static"))
        type str)
    (setq type (read-string "Enter the data type to cast to: "))
    (setq str (completing-read "Enter the type of cast: "
                               '("static" "dynamic" "reinterpret" "const")
                               nil t nil my/cast-history-list))
    (if (= 0 (length str))
        (setq str initial))
    (save-excursion
      (goto-char end)(insert ")")
      (goto-char start)(insert str "_cast<" type ">("))))

(provide 'custom-coding)
;;; custom-coding.el ends here
