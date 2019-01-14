;;; treemacs.el --- A tree style file viewer package -*- lexical-binding: t -*-

;; Copyright (C) 2018 Alexander Miller

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
;;; Functions relating to using the mouse in treemacs.

;;; Code:

(require 'xref)
(require 'easymenu)
(require 'hl-line)
(require 'treemacs-impl)
(require 'treemacs-tags)
(require 'treemacs-follow-mode)
(require 'treemacs-filewatch-mode)
(eval-and-compile (require 'treemacs-macros))

(defun treemacs-leftclick-action (event)
  "Move focus to the clicked line.
Must be bound to a mouse click, or EVENT will not be supplied."
  (interactive "e")
  (when (eq 'mouse-1 (elt event 0))
    (unless (eq major-mode 'treemacs-mode)
      ;; no when-let - the window must exist or this function would not be called
      (select-window (treemacs-get-local-window)))
    (goto-char (posn-point (cadr event)))
    (when (region-active-p)
      (keyboard-quit))
    ;; 7th element is the clicked image
    (when (->> event (cadr) (nth 7))
      (treemacs-do-for-button-state
       :on-file-node-closed (treemacs--expand-file-node btn)
       :on-file-node-open   (treemacs--collapse-file-node btn)
       :on-tag-node-closed  (treemacs--expand-tag-node btn)
       :on-tag-node-open    (treemacs--collapse-tag-node btn)
       :no-error            t))
    (treemacs--evade-image)))

(defun treemacs-doubleclick-action (event)
  "Run the appropriate doubeclick action for the current node.
In the default configuration this means to do the same as `treemacs-RET-action'.

This function's exact configuration is stored in
`treemacs-doubleclick-actions-config'.

Must be bound to a mouse click, or EVENT will not be supplied."
  (interactive "e")
  (when (eq 'double-mouse-1 (elt event 0))
    (goto-char (posn-point (cadr event)))
    (when (region-active-p)
      (keyboard-quit))
    (-when-let (state (treemacs--prop-at-point :state))
      (--if-let (cdr (assq state treemacs-RET-actions-config))
          (progn
            (funcall it)
            (treemacs--evade-image))
        (treemacs-pulse-on-failure "No double click action defined for node of type %s."
          (propertize (format "%s" state) 'face 'font-lock-type-face))))))

(defun treemacs-single-click-expand-action (event)
  "A modified single-leftclick action that expands the clicked nodes.
Can be bound to <mouse1> if you prefer to expand nodes with a single click
instead of a double click. Either way it must be bound to a mouse click, or
EVENT will not be supplied.

Clicking on icons will expand a file's tags, just like
`treemacs-leftclick-action'."
  (interactive "e")
  (when (eq 'mouse-1 (elt event 0))
    (unless (eq major-mode 'treemacs-mode)
      ;; no when-let - the window must exist or this function would not be called
      (select-window (treemacs-get-local-window)))
    (goto-char (posn-point (cadr event)))
    (when (region-active-p)
      (keyboard-quit))
    ;; 7th element is the clicked image
    (if (->> event (cadr) (nth 7))
      (treemacs-do-for-button-state
       :on-file-node-closed (treemacs--expand-file-node btn)
       :on-file-node-open   (treemacs--collapse-file-node btn)
       :on-tag-node-closed  (treemacs--expand-tag-node btn)
       :on-tag-node-open    (treemacs--collapse-tag-node btn)
       :no-error            t)
      (-when-let (state (treemacs--prop-at-point :state))
        (funcall (cdr (assoc state treemacs-doubleclick-actions-config)))))
    (treemacs--evade-image)))

(defun treemacs-define-doubleclick-action (state action)
  "Define the behaviour of `treemacs-doubleclick-action'.
Determines that a button with a given STATE should lead to the execution of
ACTION.

First deletes the previous entry with key STATE from
`treemacs-doubleclick-actions-config' and then inserts the new tuple."
  (setq treemacs-doubleclick-actions-config (assq-delete-all state treemacs-doubleclick-actions-config))
  (push (cons state action) treemacs-doubleclick-actions-config))

;;;###autoload
(defun treemacs-node-buffer-and-position (&optional _)
  "Return source buffer or list of buffer and position for the current node.
This information can be used for future display. Stay in the selected window and
ignore any prefix argument."
  (interactive "P")
  (treemacs-without-messages
    (treemacs--execute-button-action
     :file-action (find-file-noselect (treemacs-safe-button-get btn :path))
     :dir-action (find-file-noselect (treemacs-safe-button-get btn :path))
     :tag-action (treemacs--tag-noselect btn)
     :window (selected-window)
     :save-window t
     :ensure-window-split nil
     :no-match-explanation "")))

(defun treemacs--imenu-tag-noselect (file tag-path)
  "Return a list of the source buffer for FILE and the position of the tag from TAG-PATH."
  (let ((tag (car tag-path))
        (path (cdr tag-path)))
    (condition-case e
        (progn
          (find-file-noselect file)
          (let ((index (treemacs--get-imenu-index file)))
            (dolist (path-item path)
              (setq index (cdr (assoc path-item index))))
            (-let [(buf . pos) (treemacs--extract-position
                              (cdr (--first
                                    (equal (car it) tag)
                                    index)))]
              ;; some imenu implementations, like markdown, will only provide
              ;; a raw buffer position (an int) to move to
	      (list (or buf (get-file-buffer file)) pos))))
      (error
       (treemacs-log "Something went wrong when finding tag '%s': %s"
                      (propertize tag 'face 'treemacs-tags-face)
                      e)))))

(defun treemacs--tag-noselect (btn)
  "Return list of tag source buffer and position for BTN for future display."
  (cl-flet ((xref-definition
             (identifier)
             "Return the first definition of string IDENTIFIER."
             (car (xref-backend-definitions (xref-find-backend) identifier)))
            (xref-item-buffer
             (item)
             "Return the buffer in which xref ITEM is defined."
             (marker-buffer (save-excursion (xref-location-marker (xref-item-location item)))))
            (xref-item-position
             (item)
             "Return the buffer position where xref ITEM is defined."
             (marker-position (save-excursion (xref-location-marker (xref-item-location item))))))
    (-let [(tag-buf . tag-pos)
           (treemacs-with-button-buffer btn
             (-> btn (treemacs-button-get :marker) (treemacs--extract-position)))]
      (if tag-buf
          (list tag-buf tag-pos)
        (pcase treemacs-goto-tag-strategy
          ('refetch-index
           (let (file tag-path)
             (with-current-buffer (marker-buffer btn)
               (setq file (treemacs--nearest-path btn)
                     tag-path (treemacs--tags-path-of btn)))
             (treemacs--imenu-tag-noselect file tag-path)))
          ('call-xref
           (let ((xref (xref-definition
                        (treemacs-with-button-buffer btn
                          (treemacs--get-label-of btn)))))
             (when xref
               (list (xref-item-buffer xref) (xref-item-position xref)))))
          ('issue-warning
           (treemacs-log "Tag '%s' is located in a buffer that does not exist."
                          (propertize (treemacs-with-button-buffer btn (treemacs--get-label-of btn)) 'face 'treemacs-tags-face)))
          (_ (error "[Treemacs] '%s' is an invalid value for treemacs-goto-tag-strategy" treemacs-goto-tag-strategy)))))))

(defun treemacs-rightclick-menu (event)
  "Show a contextual right click menu based on click EVENT."
  (interactive "e")
  (treemacs-without-following
   (unless (eq major-mode 'treemacs-mode)
     ;; no when-let - the window must exist or this function would not be called
     (select-window (treemacs-get-local-window)))
   (goto-char (posn-point (cadr event)))
   (hl-line-highlight)
   ;; need this timer workaround because otherwise point and hl-line
   ;; don't move properly
   (run-with-idle-timer
    0.001 nil
    (lambda ()
      (let* ((node    (treemacs-node-at-point))
             (project (treemacs-project-at-point))
             (menu
              (easy-menu-create-menu
               "Treemacs"
               `(["Open"   treemacs-visit-node-no-split :visible (not (null ,node))]
                 ("Open With" :visible (not (null ,node))
                  ["Open Directly"              treemacs-visit-node-no-split]
                  ["Open With Vertical Split"   treemacs-visit-node-vertical-split]
                  ["Open With Horizontal Split" treemacs-visit-node-horizontal-split])
                 ("File Management"
                  ["Rename"           treemacs-rename :visible (not (null ,node))]
                  ["Delete"           treemacs-delete :visible (not (null ,node))]
                  ["Create File"      treemacs-create-file]
                  ["Create Directory" treemacs-create-dir])
                 ("Projects"
                  ["Add Project"            treemacs-add-project]
                  ["Add Projectile Project" treemacs-projectile                    :visible (featurep 'treemacs-projectile)]
                  ["Remove Project"         treemacs-remove-project-from-workspace :visible (not (null ,project))]
                  ["Rename Project"         treemacs-rename-project                :visible (not (null ,project))])
                 ("Toggles"
                  ["Dotfile Visibility" treemacs-toggle-show-dotfiles]
                  [,(format "Follow-Mode (Currently %s)"
                            (if treemacs-follow-mode "Enabled" "Disabled"))
                   treemacs-follow-mode]
                  [,(format "Filewatch-Mode (Currently %s)"
                            (if treemacs-filewatch-mode "Enabled" "Disabled"))
                   treemacs-filewatch-mode]
                  [,(format "Fringe-Indicator-Mode (Currently %s)"
                            (if treemacs-fringe-indicator-mode "Enabled" "Disabled"))
                   treemacs-fringe-indicator-mode])
                 ("Help"
                  ["Show Helpful Hydra"     treemacs-helpful-hydra]
                  ["Show Active Extensions" treemacs-show-extensions]
                  ["Show Changelog"         treemacs-show-changelog])
                 )))
             (choice (x-popup-menu event menu)))
        (when choice (call-interactively (lookup-key menu (apply 'vector choice)))))))))

(provide 'treemacs-mouse-interface)

;;; treemacs-mouse-interface.el ends here
