;; -*- Mode: Emacs-Lisp -*-
;;
;;;;;;;;;;;;;;;;;;;;;;;;; Dan Harms compiling.el ;;;;;;;;;;;;;;;;;;;;;;;;;
;;

(defvar one-window-in-frame nil)
(defvar my/compile-command "make")

;; automatically scroll compilation window
(setq compilation-scroll-output t)

(defun my/compilation-mode-hook()
  (setq truncate-lines nil) ; is buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil))
(add-hook 'compilation-mode-hook 'my/compilation-mode-hook)

(defun create-compile-command() "Initialize the compile command."
  (interactive)
  (find-project-root)
  (format "cd %s && %s"
          (concat my/project-root my/build-sub-dir)
          my/compile-command))

(defun my/compile() (interactive)
  (setq one-window-in-frame (one-window-p t))
  (setq compile-command (create-compile-command))
  (call-interactively 'compile)
  )
(defun my/recompile() (interactive)
  (setq one-window-in-frame (one-window-p t))
  (call-interactively 'recompile)
  )

(add-hook 'compilation-start-hook '(lambda (process)
                                        ; the compile is about to start
                                     ))

(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if it succeeded without warnings."
  (if (and
       (string-match "compilation" (buffer-name buffer))
       (string-match "finished" string)
       (not
        (with-current-buffer buffer
          (goto-char 1)
          (search-forward "warning" nil t)
          )))
      (run-with-timer 2 nil
                      (lambda (buf)
                        (bury-buffer buf)
                        (if one-window-in-frame
                            (delete-window (get-buffer-window buf t))
                          (switch-to-prev-buffer (get-buffer-window buf t)
                                                 'kill))) buffer)))

(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)
