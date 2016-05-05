;; init.el --- Initialization file
;; Copyright (C) 2015, 2016  Dan Harms (dharms)
;; Author: Dan Harms <danielrharms@gmail.com>
;; Created: Friday, February 27, 2015
;; Version: 1.0
;; Modified Time-stamp: <2016-05-04 23:02:55 dharms>
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; load-path ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (defconst my/user-directory (expand-file-name
                               (if (boundp 'user-emacs-directory)
                                   user-emacs-directory
                                 "~/.emacs.d/")))
  (defconst my/scratch-directory (concat my/user-directory "etc/"))
  (defconst my/elisp-directory (concat my/user-directory "elisp/"))
  (defconst my/plugins-directory (concat my/user-directory "plugins/"))
  (add-to-list 'load-path my/plugins-directory)
  (add-to-list 'load-path my/elisp-directory)
  (add-to-list 'load-path (concat my/user-directory "modes/"))
  (add-to-list 'load-path (concat my/user-directory "custom/"))
  )
(defconst my/user-settings
  (concat my/user-directory "settings/user/" user-login-name))
(load my/user-settings t)
(defconst my/system-name
  (car (reverse (split-string (symbol-name system-type) "\\/" t)))
  "A simplified result from uname.")
(defconst my/os-dir
  (concat my/user-directory "settings/os/" my/system-name "/")
  "Directory in which os-specific settings reside.")
(defconst my/gui-dir
  (concat my/user-directory "settings/gui/")
  "A path to a directory containing window-system-specific settings.")

(eval-when-compile
  (setq use-package-verbose t)
  (require 'use-package))
(require 'bind-key)

(set-register ?~ (cons 'file "~/"))
(set-register ?\C-i (cons 'file user-init-file)) ;edit init file
(set-register ?\C-d (cons 'file "~/Documents"))
(set-register ?\C-k (cons 'file "~/Desktop"))
(set-register ?\C-w (cons 'file "~/Downloads"))
(set-register ?\C-s (cons 'file "~/src"))
(set-register ?\C-h (cons 'file "~/src/harmsway"))
(set-register ?\C-e (cons 'file "~/src/harmsway/.emacs.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; auto-save ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my/autosave-dir (concat my/user-directory "autosaves/"))
(unless (file-directory-p my/autosave-dir)
  (make-directory my/autosave-dir t))
(setq auto-save-file-name-transforms
      `((".*" ,(concat my/autosave-dir "\\1") t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; backups ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my/backup-dir
  (concat my/user-directory "backups/" (format-time-string "%Y-%m-%d")))
(unless (file-directory-p my/backup-dir)
  (make-directory my/backup-dir t))
(setq backup-directory-alist `(("." . ,my/backup-dir)))
(setq delete-by-moving-to-trash t)
(setq backup-by-copying t
      version-control t
      delete-old-versions t
      kept-old-versions 0               ;oldest versions to keep
      kept-new-versions 10
      auto-save-timeout 60
      auto-save-interval 0              ;disable autosaves due to input events
      )

;; Suppress GNU startup message
(setq inhibit-startup-message t)
(setq inhibit-default-init t)
(setq line-number-mode t)
(setq column-number-mode t)
(setq use-dialog-box nil)
(setq gc-cons-threshold 20000000)
(setq kill-do-not-save-duplicates t)
(file-name-shadow-mode 1)
(setq enable-recursive-minibuffers t)
;; interactive regexp-search space character stands only for 1 char
(setq-default search-whitespace-regexp nil)
;;  truncate long lines
(setq-default truncate-lines t)
(defun my/set-word-processor()
  (visual-line-mode 1)
  ;; uncomment to move by logical lines, not visual lines
  ;; (setq line-move-visual nil)
  ;; uncomment as an alternative to visual-line-mode that only word
  ;; wraps, without removing wrap indicators in the fringe, and without
  ;; altering movement commands to use visual lines rather than logical ones.
  ;; (setq truncate-lines nil)
  ;; (setq word-wrap t)
  )
;; default tab width
(setq-default tab-width 4)
;; Show selections
(transient-mark-mode 1)
;; enable repeatedly popping mark without prefix
(setq set-mark-command-repeat-pop t)
(defun my/multi-pop-to-mark (orig-fun &rest args)
  "Call ORIG-FUN until the cursor moves. Try the repeated popping
up to 10 times."
  (let ((p (point)))
    (dotimes (i 10)
      (when (= p (point))
        (apply orig-fun args)))))
(advice-add 'pop-to-mark-command :around
            #'my/multi-pop-to-mark)
;; show current function
(which-function-mode t)
;; Insertion while text is selected deletes the selected text
(delete-selection-mode 1)
;; winner mode
(winner-mode 1)
;; append unique parent directory to buffers of same name
(toggle-uniquify-buffer-names)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; don't try to create "other files"
(setq ff-always-try-to-create nil)
;; Preserve line position on scroll
(setq scroll-preserve-screen-position t)
(show-paren-mode t)
(size-indication-mode 1)
;; don't add new-lines to end of buffer on scroll
(setq next-line-add-newlines nil)
;; allow converting regions to upper/lower case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'narrow-to-region 'disabled nil)
;; disable nuisances
(put 'overwrite-mode 'disabled t)
(fset 'yes-or-no-p 'y-or-n-p)
;; reuse frames
(setq-default display-buffer-reuse-frames t)
;; visual settings
(menu-bar-mode -1)
(setq-default fill-column 78)
(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
;; default colors
;; (set-foreground-color "white")
;; (set-background-color "black")
(set-cursor-color "yellow")
(set-mouse-color "white")
(mouse-avoidance-mode 'cat-and-mouse)
(blink-cursor-mode 1)
(setq blink-cursor-blinks 0)
(setq ring-bell-function (lambda() ()))
(when (display-graphic-p)
  (global-unset-key "\C-z"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; fonts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(defun my/syntax-color-hex-values()
  "Syntax color text of the form #FF1100 in a buffer.
Cf. `http://ergoemacs.org/emacs/emacs_CSS_colors.html'."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[AaBbCcDdEeFf[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; key-bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "<f1>"))
(global-set-key [(next)] 'scroll-up-line)
(global-set-key [(prior)] 'scroll-down-line)
(global-set-key "\C-caa" 'align)
(global-set-key "\C-car" 'align-repeat-regexp)
(global-set-key [f5] 'toggle-truncate-lines)
(global-set-key "\C-c5" 'toggle-truncate-lines)
(global-set-key "\C-c " 'whitespace-mode)
(global-set-key "\C-c0f" 'font-lock-fontify-buffer)
(global-set-key "\e\es" 'speedbar)
(global-set-key "\e\eo" 'speedbar-get-focus)
(global-set-key "\M-sf" 'ff-find-other-file)
(global-set-key (kbd "M-#") 'sort-lines)
(global-set-key (kbd "C-#") 'sort-paragraphs)
(global-set-key "\C-xw" 'write-region)

;; This horrible hack gets around a "reference to free variable" warning,
;; I believe due to a defadvice referring to `filename' in the original
;; code being advised.  But I couldn't find where.
;; More recent emacsen seem to handle the error.
(when (version< emacs-version "24.3")
  (defvar filename nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; dash ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (when (version< "24.3" emacs-version)
    (require 'dash)
    (eval-after-load "dash" '(dash-enable-font-lock))))

;; (when (version< "24.3" emacs-version)
;;   (require 's))
;; (require 'f)
;; (require 'deferred)
;; (require 'concurrent)
;; (require 'epc)
;; (require 'epcs)

;;;;;;; FUNCTIONS ;;;;;;;
;; ; man-page lookups
;; (defun openman () "lookup man page" (interactive)
;;    (manual-entry (current-word)))
;; ; convert tabs to spaces
;; (defun untabify-buffer () "untabify current buffer" (interactive)
;;    (save-excursion
;;      (untabify (point-min) (point-max))))
;; ; shell command on region
;; (defun shell-command-on-buffer (cmd) (interactive "sShell command on buffer: ")
;;   (shell-command-on-region (point-min) (point-max) cmd t t
;; ))



(load-library "compiling")
(load-library "coding")

(use-package custom-utils
  :bind
  ("C-x C-M-e" . sanityinc/eval-last-sexp-or-region)
  :commands
  (insert-now now insert-today today find-file-upwards find-file-dir-upwards
              goto-line-with-feedback
              shell-command-redirected-output
              ))

(use-package custom-text-utils
  :bind (("M-s i" . my/indent-line-relative)
         ("\e\e\\" . jump-to-matching-paren)
         ("M-]" . highlight-paren-right)
         ("M-[" . highlight-paren-left)
         ("M-s p" . highlight-enclosing-paren)
         ("\e\er" . highlight-current-sexp)
         ("C-c q" . clean-up-buffer)
         ("\e\e(" . enclose-by-braces-paren)
         ("\e\e[" . enclose-by-braces-bracket)
         ("\e\e{" . enclose-by-braces-brace)
         ("\e\e<" . enclose-by-braces-caret)
         ))

(use-package custom-environment
  :commands (read-file-into-list-of-lines
             load-environment-variable-from-file
             my/load-environment-variables-from-file
             ))

(use-package custom-buffer-utils
  :bind (("C-x C-r" . my/revert-buffer)
         ("C-x K" . kill-other-buffers)
         ("\e\ep" . switch-to-most-recent-buffer)
         ("C-x 4z" . window-toggle-split-direction)
         ("C-x 4s" . swap-buffers)
         ("C-c 0w" . my/toggle-window-dedicated)
         ("C-x 5x" . move-buffer-to-new-frame)
         )
  :commands
  (move-buffer-file move-buffer-to-new-frame)
  )

(use-package custom-word-count
  :if (version< emacs-version "24.0")
  :bind ("M-=" . wordcount)
  )

(use-package custom-grep
 :bind ("C-c g" . my/grep)
 :commands grep)
(use-package custom-coding
  :bind (("C-c p" . print-current-function)
         ("C-c ii" . add-header-include-ifdefs)
         ("C-c h" . insert-class-header)
         ("C-c c" . insert-cast)
         ("C-c n" . wrap-namespace-region)
  ))
(use-package custom-gud
  :bind (("C-c 4" . my/launch-gdb)
         ([f4] . my/launch-gdb)
         )
  :config
  (add-hook 'gud-mode-hook
            (lambda()
              (set (make-local-variable 'gdb-show-main) t)
              ;; highlight recently-changed variables
              (set (make-local-variable 'gdb-show-changed-values) t)
              ;; watch expressions sharing same variable name
              (set (make-local-variable 'gdb-use-colon-colon-notation) t)
              (set (make-local-variable 'gdb-create-source-file-list) nil)
              (gdb-many-windows 1)
              )))

;;;;;;;;;;;;;;;;;;;;;;;;;;; remote-host-connector ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package remote-host-connector
 :bind (("C-c 6" . my/connect-to-remote-host)
        ([f6] . my/connect-to-remote-host)
        )
 :init
 (defvar my/remote-hosts-file "")
 (defvar my/remote-host-list '())
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; aes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my/aes-default-group "  default")
(use-package aes
  :demand t
  :config
  (setq aes-always-ask-for-passwords nil)
  (setq aes-enable-plaintext-password-storage t)
  (setq aes-delete-passwords-after-idle 0)
  (aes-enable-auto-decryption)
  (add-hook 'aes-path-passwd-hook (lambda (path) my/aes-default-group))
  ;; if the environment variable is not defined, we will be prompted
  ;; for the password
  (setq aes--plaintext-passwords
        (let ((pwd (or (getenv "EMACS_PWD") "nil")))
          (list (cons my/aes-default-group pwd))))
  (global-set-key "\C-c0z" 'aes-toggle-encryption)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; path ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(my/load-environment-variables-from-file my/os-dir)

(setq-default frame-title-format
              '(:eval
                (format "%s@%s: %s %s"
                        (or (file-remote-p default-directory 'user)
                            user-real-login-name)
                        (or (file-remote-p default-directory 'host)
                            system-name)
                        (if dired-directory
                            (concat "{" (buffer-name) "}")
                          (buffer-name))
                        (if (and (featurep 'profiles+)
                                 (profile-current-get 'project-name))
                            ;; the parent profile "default" happens to
                            ;; have an empty 'project-name attribute
                            (concat
                             "("
                             (upcase (symbol-name profile-current))
                             ")")
                          "")           ;else empty if no project name
                        )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; full-edit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package full-edit :bind ("C-c C-f" . full-edit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; c-includer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package c-includer
  :bind ("C-c it" . makey-key-mode-popup-c-includer-brackets))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; cleanup-funcs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cleanup-funcs
  :bind ("C-c ic" . makey-key-mode-popup-c-cleanup-funcs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; multi-line ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "multi-line/")))
(use-package
  multi-line
  :bind ("C-c w" . multi-line)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; emacs-refactor ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "emacs-refactor/")))
(use-package
 emr
 :init
 (with-eval-after-load 'prog-mode
   (add-hook 'prog-mode-hook 'emr-initialize)
   (bind-key "C-c b" 'emr-show-refactor-menu)
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sudo-edit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  sudo-edit
  :bind
  (("C-c 0rr" . sudo-edit)
   ("C-c 0rf" . sudo-edit-current-file))
  )


;; work around bug in cc-mode in emacs 24.4
;; see debbugs.gnu.org/db/18/18845.html
(eval-and-compile
  (when (< emacs-major-version 24)
    (add-to-list 'load-path (concat my/elisp-directory "compat/24/0/-/")))
  (when (< emacs-major-version 25)
    (add-to-list 'load-path (concat my/elisp-directory "compat/25/0/-/")))
  )
(eval-when-compile
  (if (and (= emacs-major-version 24) (= emacs-minor-version 4))
      (require 'cl)))
(if (= emacs-major-version 23)
    (progn
      (autoload 'protobuf-mode "protobuf-mode" "Major mode for editing protobuf files." t)
      (autoload 'csharp-mode "csharp-mode" "Major mode for editing csharp files." t)
      )
  (use-package protobuf-mode :mode "\\.proto$")
  (use-package csharp-mode :mode "\\.cs$")
  )

(use-package pos-tip :defer t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rainbow ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rainbow-mode
  :if (version< "24.3" emacs-version)
  :config
  ;; enable for emacs-lisp-mode
  (add-to-list 'rainbow-html-colors-major-mode-list 'emacs-lisp-mode)
  (add-to-list 'rainbow-x-colors-major-mode-list 'emacs-lisp-mode)
  (add-to-list 'rainbow-ansi-colors-major-mode-list 'emacs-lisp-mode)
  (add-to-list 'rainbow-r-colors-major-mode-list 'emacs-lisp-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rotate ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rotate
  :bind (:map ctl-x-4-map
              ("l" . rotate-layout)
              ("w" . rotate-window)
              ("h" . rotate:even-horizontal)
              ("\C-h" . rotate:main-horizontal)
              ("v" . rotate:even-vertical)
              ("\C-v" . rotate:main-vertical)
              ("t" . rotate:tiled)
              ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;; electric-buffer-list ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ebuff-menu :bind ("C-x M-b" . electric-buffer-list))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ibuffer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :init
  (setq ibuffer-expert t)
  (setq ibuffer-show-empty-filter-groups nil)
  (add-hook 'ibuffer-mode-hook
            (lambda()
              (ibuffer-auto-mode 1)
              (ibuffer-vc-set-filter-groups-by-vc-root)
              ))
  :config
  (use-package ibuffer-vc)
  ;; human-readable sizes
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1048576)
      (format "%7.1fM" (/ (buffer-size) 1048576.0)))
     ((> (buffer-size) 131072)
      (format "%7.0fk" (/ (buffer-size) 1024.0)))
     ((> (buffer-size) 1024)
      (format "%7.1fk" (/ (buffer-size) 1024.0)))
     (t (format "%8d" (buffer-size)))))
  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                filename-and-process)
          (mark modified read-only vc-status-mini " "
                (size-h 9 -1 :right)
                " "
                (name 26 -1))
          (mark modified read-only vc-status-mini " "
                (size-h 9 -1 :right)
                " "
                (filename-and-process 26 -1))
          ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; gen-tags ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package gen-tags
  :demand t                             ;load immediately
  :bind ("C-c t" . gen-tags-generate-tags)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; tags ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar tag-lookup-target-profile nil
  "The working profile in effect when a tag is first looked up.")
(defun my/store-profile ()
  (setq tag-lookup-target-profile (symbol-name profile-current)))
(defun my/tags-find-tag ()
  (interactive)
  (my/store-profile)
  (etags-select-find-tag))
(defun my/tags-find-tag-at-point ()
  (interactive)
  (my/store-profile)
  (etags-select-find-tag-at-point))

;; select
(use-package etags-select
  :init
  (setq tags-revert-without-query t)
  :bind (("M-." . my/tags-find-tag)
         ([?\C-\M-.] . my/tags-find-tag-at-point))
  :demand t
  :config
  ;; stack
  (use-package etags-stack :bind ("C-c C-t" . etags-stack-show))
  ;; table
  (use-package etags-table
    :init
    ;; we store our tags in a specific directory
    (setq etags-table-search-up-depth nil)
    )
  )

;; This (unused) snippet overrides tag lookup for standard tags, not
;; etags-select.  This would (untested) make tag lookup tramp-aware.  See
;; emacs.stackexchange.com/questions/53/ctags-over-tramp
;; (defun my/etags-file-of-tag (&optional relative)
;;   (save-excursion
;;     (re-search-backward "\f\n\\([^\n]+\\),[0-9]*\n")
;;     (let ((str (convert-standard-filename
;;                 (buffer-substring (match-beginning 1) (match-end 1)))))
;;       (if relative str
;;         (let ((basedir (file-truename default-directory)))
;;           (if (file-remote-p basedir)
;;               (with-parsed-tramp-file-name basedir nil
;;                 (message "drh *** str=%s basedir=%s result=%s"
;;                          str basedir
;;                          (expand-file-name
;;                           (apply 'tramp-make-tramp-file-name
;;                                  (list method user host str hop))))
;;                 (expand-file-name (apply 'tramp-make-tramp-file-name
;;                                          (list method user host str hop))))
;;             (expand-file-name str basedir)))))))
;; (setq file-of-tag-function 'my/etags-file-of-tag)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; yascroll ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yascroll :config (global-yascroll-bar-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; copyright ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package copyright
  :init
  ;; copyright-update is added to my/before-save-hook below
  (setq copyright-query nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; hide-lines ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package hide-lines :bind ("C-c l" . hide-lines))

;;;;;;;;;;;;;;;;;;;;;;;;;;;; line-comment-banner ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package line-comment-banner
  :bind ([?\C-c?\C-/] . line-comment-banner)
  :init
  (add-hook 'c-mode-common-hook
            (lambda() (make-local-variable 'comment-fill)
              (setq comment-fill "*")))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; list-register ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package list-register :bind ("C-x rv" . list-register))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; discover-my-major ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package discover-my-major :bind ("C-h C-m" . discover-my-major))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; expand-region ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; this removes the binding for "M-'" to 'abbrev-prefix-mark, without which we
;; can use "M-'" as a prefix binding (one which happens to work in the
;; terminal as well).
(define-key esc-map "'" nil)
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "expand-region/")))
(use-package expand-region
  :bind (("C-'" . er/expand-region)
         ("M-' '" . er/expand-region)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; embrace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package embrace
  :bind (("C-=" . embrace-commander)
         ("M-' =" . embrace-commander)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; iedit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
 iedit
 :bind (("C-;" . iedit-mode)
        ("M-' ;" . iedit-mode)
        ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; idle-highlight ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package idle-highlight-mode
  :disabled t
  :init
  (setq idle-highlight-idle-time 10)
  :config
  (add-hook 'prog-mode-hook #'idle-highlight-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ascii ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ascii :bind ("M-s a" . ascii-display))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; magit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-prefix-command 'my/git-keymap)
(global-set-key "\M-sm" 'my/git-keymap)
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "magit/lisp/")))
(use-package magit
  :if (not (version< emacs-version "24.4"))
  :init
  (eval-and-compile (setq magit-need-cygwin-noglob nil))
  (setq magit-status-buffer-name-format "*magit: %b*"
        magit-log-show-margin t
        magit-popup-show-common-commands nil
        magit-log-show-refname-after-summary nil
        magit-no-confirm '()
        magit-diff-refine-hunk t
        magit-auto-revert-tracked-only t
        magit-prefer-remote-upstream t
        )
  ;; git commands
  :bind (:map my/git-keymap
              ("g" . magit-status)
              ("M-g" . magit-dispatch-popup)
              ("f" . magit-find-file) ;; view arbitrary blobs
              ("4f" . magit-find-file-other-window)
              ("h" . magit-log-buffer-file) ;; show all commits that touch current file
              ("y" . magit-cherry)
              ("e" . ediff-merge-revisions-with-ancestor) ;; to see all differences, even those automatically merged
              ("m" . magit-toggle-margin)
              ("b" . magit-blame)
              ("U" . magit-unstage-all) ;; unstage all changes (like SU but forces HEAD)
              ("s" . magit-stage-file)
              ("u" . magit-unstage-file)
              ("r" . magit-reset-soft) ;; soft reset; hard reset can use C-u x
              ("d" . magit-diff-buffer-file-popup)
              )
  :config
  (use-package with-editor)
  (global-magit-file-mode 1)
  (magit-auto-revert-mode 0)
  ;; add this as of magit 2.4.0
  ;; (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  ;; add ido shortcut
  (if (version< emacs-version "25.1")
      (add-hook
       'ido-setup-hook
       (lambda() (define-key ido-completion-map
                   (kbd "C-x g") 'ido-enter-magit-status)))
    (define-key ido-common-completion-map
      (kbd "C-x g") 'ido-enter-magit-status))

  ;; add argument --no-merges to log
  (magit-define-popup-switch 'magit-log-popup
    ?m "Omit merge commits" "--no-merges")
  (setq magit-log-arguments (append
                             (list "--no-merges" "--color")
                             magit-log-arguments))
  ;; show status buffer alone
  (setq magit-post-display-buffer-hook
        (lambda ()
          (when (derived-mode-p 'magit-status-mode)
            (delete-other-windows))))
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; git-timemachine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package git-timemachine
  :bind (:map my/git-keymap ("t" . git-timemachine)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; shell-pop ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package shell-pop
  :bind (("<f1>" . shell-pop)
         ("C-c 1" . shell-pop)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; shackle ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package shackle
  :config
  (setq shackle-default-ratio 0.4)
  (setq shackle-select-reused-windows nil)
  (setq shackle-rules
        '(
          (occur-mode :select nil)
          (grep-mode :popup t :select nil :align bottom)
          ("*Help*" :popup t :select t)
          (diff-mode :popup t :select t)
          (apropos-mode :popup t :select t)
          (completion-list-mode :select nil)
          (compilation-mode :popup t :select nil :align bottom)
          ("*Shell Command Output*" :select t)
          ("COMMIT_EDITMSG" :select t)
          )
        shackle-default-rule '(:select nil)
        )
  (shackle-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; hl-line ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package hl-line+ :bind ("M-s L" . hl-line-flash))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; crosshairs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package crosshairs :bind ("M-s l" . crosshairs-flash))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; beacon ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package beacon
  :bind ("M-s C-l" . beacon-blink)
  :demand t
  :config
  (add-to-list 'beacon-dont-blink-major-modes 'etags-select-mode)
  (beacon-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; bookmark+ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "bookmark+/")))
(use-package bookmark+
  :bind (("<f7>" . bmkp-previous-bookmark)
         ("C-c 7" . bmkp-previous-bookmark)
         ("<f8>" . bmkp-next-bookmark)
         ("C-c 8" . bmkp-next-bookmark)
         )
  :demand t
  :config
  (setq bookmark-default-file (concat my/user-directory "bookmarks")
        bmkp-bmenu-state-file (concat my/user-directory
                                      "emacs-bmk-bmenu-state")
        bookmark-save-flag nil
        bmkp-crosshairs-flag nil
        bmkp-last-as-first-bookmark-file nil
        )
  (add-hook 'bookmark-after-jump-hook #'crosshairs-flash)
  (add-hook 'after-init-hook
            (lambda ()
              (unless (> (length command-line-args) 1)
                (bookmark-bmenu-list)
                (switch-to-buffer "*Bookmark List*"))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; savehist ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package savehist
  :defer 10
  :config
  (setq savehist-additional-variables
        '(search-ring regexp-search-ring kill-ring compile-history)
        savehist-file (concat my/user-directory "history")
        savehist-save-minibuffer-history t
        history-length 50
        history-delete-duplicates t
        )
  (put 'minibuffer-history 'history-length 100)
  (put 'kill-ring 'history-length 25)
  (savehist-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; recentf ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package recentf
  :defer 10
  :config
  (setq recentf-max-saved-items 200
        recentf-max-menu-items 12
        recentf-save-file (concat my/user-directory "recentf"))
  (setq recentf-exclude '( "-tags\\'" "ido\.last\\'" "emacs-bmk-bmenu-state"))
  (recentf-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; uniquify-recentf ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar uniquify-recentf-func 'recentf-open-files
  "Select recent files from `recentf' via a completion function.")
(defun my/call-recentf-func () (interactive) (funcall uniquify-recentf-func))
(use-package uniquify-recentf
  :bind ("M-r" . my/call-recentf-func)
  :commands
  (uniquify-recentf-ivy-recentf-open uniquify-recentf-ido-recentf-open)
  :if (version< "24.3" emacs-version)
  :config
  (setq uniquify-recentf-func 'uniquify-recentf-ivy-recentf-open)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ido ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my/completion-framework-alist (list
                                       (cons "ido" 'my/activate-ido))
  "An alist of completion frameworks to choose among.  Each value is a
 cons cell (`description' . `activation-function' ).")
(use-package ido
  :demand t
  :config
  (setq ido-save-directory-list-file (concat my/user-directory "ido-last"))
  (setq ido-max-prospects 25)
  ;; (setq ido-enable-flex-matching t)
  ;; (setq ido-case-fold t)
  (setq ido-auto-merge-work-directories-length -1) ;disables auto-merge
  (add-to-list 'ido-work-directory-list-ignore-regexps tramp-file-name-regexp)
  ;; ask before reusing an existing buffer
  (setq-default ido-default-buffer-method 'maybe-frame)
  (setq-default ido-default-file-method 'maybe-frame)
  (ido-mode 1)

  ;; sort files by descending modified time (except remotely, which is dog-slow)
  (defun ido-sort-mtime()
    (unless (tramp-tramp-file-p default-directory)
      (setq ido-temp-list
            (sort ido-temp-list
                  (lambda (a b)
                    (time-less-p
                     (sixth (file-attributes (concat ido-current-directory b)))
                     (sixth (file-attributes (concat ido-current-directory a)))))))
      ;; (ido-to-end
      ;;  (delq nil (mapcar (lambda (x)
      ;;                      (and (char-equal (string-to-char x) ?.) x))
      ;;                    ido-temp-list)))
      ))
  (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
  (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)

  (when (< emacs-major-version 24)
    ;; use ido to switch modes when smex is not available
    (global-set-key (kbd "M-x")
                    (lambda() (interactive)
                      (call-interactively
                       (intern
                        (ido-completing-read
                         "M-x " (all-completions "" obarray 'commandp)))))))
  ;; for recentf
  ;; (unless (featurep 'uniquify-recentf)
  ;;   (defun recentf-ido-find-file()
  ;;     "Find a recent file using ido."
  ;;     (interactive)
  ;;     (let ((file (ido-completing-read
  ;;                  "Choose recent file:"
  ;;                  recentf-list nil t)))
  ;;       (when file (find-file file))))
  ;;   (global-set-key "\er" 'recentf-ido-find-file))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ace-window ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-window :bind ("M-p" . ace-window))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; isearch ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq isearch-allow-scroll t)
;; allow stopping isearch at opposite end
(defun my/isearch-exit-other-end ()
  "Exit isearch, at the opposite end of the string."
  (interactive)
  (isearch-exit)
  (goto-char isearch-other-end))
(define-key isearch-mode-map [(control return)] #'my/isearch-exit-other-end)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; occur ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-s M-o") 'multi-occur-in-matching-buffers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; swiper ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "swiper/")))
(use-package swiper
  :if (not (version< emacs-version "24.1"))
  :bind (("M-s s" . swiper)
         :map isearch-mode-map
         ("C-o" . swiper-from-isearch))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ivy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ivy
  :config
  (setq ivy-wrap t)
  (add-to-list 'my/completion-framework-alist
               (cons "ivy" 'my/activate-ivy))
  (global-set-key "\e\eii" 'ivy-resume)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; counsel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package counsel
  :bind (("C-c ff" . counsel-git)
         ("C-c fr" . counsel-git-grep)
         ("C-c fg" . counsel-grep)
         ("C-c fs" . counsel-git-stash)
         ("C-c fi" . counsel-imenu)
         ("C-c fl" . counsel-git-log)
         )
  :commands counsel-M-x
  :config
  (setq counsel-find-file-ignore-regexp "\\.elc$")
  (setf (cdr (assoc 'counsel-M-x ivy-initial-inputs-alist)) "")
  ;; fallback to basic find-file
  (define-key counsel-find-file-map "\C-x\C-f"
    (lambda ()
      (interactive)
      (ivy-set-action
       (lambda (x)
         (let ((completing-read-function 'completing-read-default))
           (call-interactively 'find-file))))
      (ivy-done)))
  ;; make matches appear fancy; supposedly doesn't work under 24.5
  ;; but seems OK to me
  (setq ivy-display-style 'fancy)
  (setq ivy-extra-directories '("./"))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; smex ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package smex
  :if (<= 24 emacs-major-version)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands))
  :config
  (smex-initialize)
  (if (boundp 'ivy-mode)
      (global-set-key "\e\ex" 'counsel-M-x)
    ;; the old M-x
    (global-set-key "\e\ex" 'execute-extended-command))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; imenu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I prefer imenu-anywhere to return imenu results only for the current
;; buffer, not all open buffers.
(use-package imenu-anywhere
  :bind ("C-c j" . imenu-anywhere)
  :init
  (defvar imenu-anywhere-buffer-list-function
    (lambda() (list (current-buffer))))
  )
(use-package imenu-scan)

(use-package popup-imenu
  :bind ("C-c C-j" . popup-imenu)
  :config
  (setq popup-imenu-position 'point)
  )

;; ;; TODO: this regexp has false positives, but at least handles when
;; ;; functions have whitespace (i.e. in namespaces).  I don't know which
;; ;; is better.  The answer may be to not use imenu at all.
;; ;; (require 'cc-mode+)
;; (defvar my/imenu-generic-expression
;;   `((nil
;;      ,(concat
;;        "\\s-*"                     ; beginning of line is required
;;        "\\(template[ \t]*<[^>]+>[ \t]*\\)?" ; there may be a "template <...>"
;;        "\\([a-zA-Z0-9_:]+[ \t]+\\)?"        ; type specs; there can be no
;;        "\\([a-zA-Z0-9_:]+[ \t]+\\)?"        ; more than 3 tokens, right?

;;        "\\("                            ; last type spec including */&
;;        "[a-zA-Z0-9_:]+"
;;        "\\([ \t]*[*&]+[ \t]*\\|[ \t]+\\)" ; either pointer/ref sign or whitespace
;;        "\\)?"                             ; if there is a last type spec
;;        "\\s-+\\("                      ; name; take that into the imenu entry
;;        "[a-zA-Z0-9_:~]+"          ; member function, ctor or dtor...
;;                                         ; (may not contain * because then
;;                                         ; "a::operator char*" would become "char*"!)
;;        "\\|"
;;        "\\([a-zA-Z0-9_:~]*::\\)?operator"
;;        "[^a-zA-Z1-9_][^(]*"             ; ...or operator
;;        " \\)"
;;        "[ \t]*([^)]*)[ \t\n]*[^;]"    ; require something other than a ; after
;;                                         ; the (...) to avoid prototypes.  Can't
;;                                         ; catch cases with () inside the parentheses
;;                                         ; surrounding the parameters
;;                                         ; (like "int foo(int a=bar()) {...}"

;;        ) 6)
;;     ("Class"
;;      ,(concat
;;        "\\s-*"                       ; beginning of line is required
;;        "\\(template[ \t]*<[^>]+>[ \t]*\\)?" ; there may be a "template <...>"
;;        "class[ \t]+"
;;        "\\([a-zA-Z0-9_]+\\)"            ; this is the string we want to get
;;        "[ \t]*[:{]"
;;        ) 2)))

;; (add-hook 'c++-mode-hook
;;           (lambda() (setq imenu-generic-expression
;;                           my/imenu-generic-expression)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; powerline ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "powerline/")))

;; does not interact with rich-minority mode: try delight.el?
;; (powerline-default-theme)
(use-package powerline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rich-minority ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rich-minority
  ;; this dependency actually comes from smart-mode-line, which uses
  ;; rich-minority.
  :if (version<= "24.3" emacs-version)
  :config
  (rich-minority-mode 1)
  (setq rm-blacklist
        '(" AC" " yas" " Undo-Tree" " Abbrev" " Guide" " Hi" " $" " ,"
          " Ifdef" " Rbow" " ivy" " ElDoc" " (*)" " wg" " ⛓" " GitGutter"
          " Fly" " drag"))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; smart-mode-line ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "smart-mode-line/")))
(use-package smart-mode-line
  :if (version<= "24.3" emacs-version)
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup)
  )

;; undo
(unless (boundp 'warning-suppress-types)
  (setq warning-suppress-types nil))
(push '(undo discard-info) warning-suppress-types)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; undo-tree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package undo-tree
  :config
  ;; reset the undo tree history (useful after reverting buffer)
  (global-set-key "\C-cu" (lambda()(interactive)(setq buffer-undo-tree nil)))
  (global-undo-tree-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; goto-chg ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package goto-chg
  :bind (([?\C-.] . goto-last-change)
         ("M-' ." . goto-last-change)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; goto-last-change ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
 goto-last-change
 :bind ("C-M-," . goto-last-change)
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; tramp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package tramp
  :defer t
  :config
  (when (boundp 'my/user-name)
    (setq tramp-default-user my/user-name))
  (setq tramp-auto-save-directory my/autosave-dir)
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (setq vc-ignore-dir-regexp
        (format "\\(%s\\)\\|\\(%s\\)"
                vc-ignore-dir-regexp tramp-file-name-regexp))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :defer t
  :init
  (setq org-src-fontify-natively t)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (sh . t)
     (python . t)
     (C . t)
     )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dired
  :defer t
  :init
  (add-hook 'dired-load-hook
            (lambda()
              (define-key dired-mode-map (kbd "<prior>") 'dired-up-directory)
              (define-key dired-mode-map "l" 'dired-launch-command)
              ))
  :config
  (use-package dired-x)                 ; C-x C-j now runs 'dired-jump
  (setq diredp-hide-details-initially-flag nil)
  (use-package dired+)
  (define-key dired-mode-map "\C-o" 'dired-display-file) ;remap
  (define-key dired-mode-map "\M-p" nil)                 ;unbind
  (use-package ls-lisp+)
  ;; omit dot-files in dired-omit-mode (C-x M-o)
  (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
  (setq ls-lisp-dirs-first t)
  (use-package dired-filter)
  (define-key dired-mode-map "." dired-filter-mark-map)
  ;; sorting
  (use-package dired-sort)
  (setq-default dired-listing-switches "-alhvGg")
  (put 'dired-find-alternate-file 'disabled nil)
  ;; next window's dired window used as target for current window operations
  (setq dired-dwim-target t)
  ;; search only in filenames
  (setq dired-isearch-filenames t)

  (defun my/dired-sort()
    "Toggle sorting in dired buffers."
    (interactive)
    (let ((type
           (funcall
            my/choose-func
            '( "size" "extension" "ctime" "utime" "time" "name")
            "Sort by:")))
      ;; on os x, extension (X) not supported;
      ;; also, ctime means time file status was last changed
      (cond ((string= type "size") (dired-sort-size))
            ((string= type "extension") (dired-sort-extension))
            ((string= type "ctime") (dired-sort-ctime))
            ((string= type "utime") (dired-sort-utime))
            ((string= type "time") (dired-sort-time))
            ((string= type "name") (dired-sort-name))
            (t (error "unknown dired sort %s" type)))))
  (define-key dired-mode-map "`" 'my/dired-sort)

  (defadvice shell-command
      (after shell-in-new-buffer (command &optional output-buffer error-buffer))
    (when (get-buffer "*Async Shell Command*")
      (with-current-buffer "*Async Shell Command*"
        (rename-uniquely))))
  (ad-activate 'shell-command)

  ;; launch command
  (defun dired-launch-command() (interactive)
         (dired-do-shell-command
          (case system-type
            (darwin "open")
            (gnu/linux "open")
            ) nil (dired-get-marked-files t current-prefix-arg)))

  ;; easily go to top or bottom
  (defun dired-back-to-top()
    (interactive)
    (let ((sorting-by-date (string-match-p dired-sort-by-date-regexp
                                           dired-actual-switches)))
      (goto-char (point-min))
      (dired-next-line
       (if sorting-by-date 2 4))))
  (define-key dired-mode-map
    (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)

  (defun dired-jump-to-bottom() (interactive)
         (goto-char (point-max))
         (dired-next-line -1))
  (define-key dired-mode-map
    (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)

  (defun my-dired-do-command (command)
    "Run command on marked files. Any files not already open will be opened.
 After this command has been run, any buffers it's modified will remain
 open and unsaved."
    (interactive "Run on marked files M-x ")
    (save-window-excursion
      (mapc (lambda (filename)
              (find-file filename)
              (call-interactively command))
            (dired-get-marked-files))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sunrise-commander ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "sunrise/")))
(use-package sunrise-commander
  :bind ("C-c 0s" . sunrise)
  :config
  (use-package sunrise-x-tree)
  (use-package sunrise-x-w32-addons)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package neotree :bind ("C-c 0n" . neotree-toggle))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; deft ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package deft
  :bind ("C-c d" . deft)
  :commands deft-find-file
  :config
  (setq deft-extensions '("org" "md" "txt"))
  (setq deft-default-extension "md")
  (setq deft-recursive t)
  ;; (setq deft-use-filename-as-title t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; diff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; better colors in older versions
(when (version< emacs-version "24.3")
  (eval-after-load 'diff-mode '(progn
                                 (set-face-attribute 'diff-added nil
                                                     :foreground "white"
                                                     :background "blue"
                                                     )
                                 (set-face-attribute 'diff-removed nil
                                                     :foreground "white"
                                                     :background "red3"
                                                     )
                                 (set-face-attribute 'diff-changed nil
                                                     :foreground "white"
                                                     :background "purple"
                                                     )
                                 )))
(global-set-key "\M-sdd" (lambda() (interactive)
                           (diff-buffer-with-file (current-buffer))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ediff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; only highlight current chunk
(setq-default ediff-highlight-all-diffs 'nil
              ediff-keep-variants nil
              ediff-forward-word-function 'forward-char
              )
(global-set-key "\M-sde" #'ediff-current-file)
(global-set-key "\M-sdb" #'ediff-buffers)
(global-set-key "\M-sdf" #'ediff-files)
(global-set-key "\M-sdr" #'ediff-revision)
;; don't use a separate control frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; toggle between control frame and control window
(add-hook 'ediff-keymap-setup-hook
          (lambda()
            (define-key ediff-mode-map "t" 'ediff-toggle-multiframe)
            ))

;; ensure wide display does not persist after quitting ediff
(defvar ediff-last-windows nil "Last ediff window configuration.")
(defun ediff-restore-windows ()
  "Restore window configuration to `ediff-last-windows'."
  (set-window-configuration ediff-last-windows)
  (remove-hook 'ediff-after-quit-hook-internal
               'ediff-restore-windows))
(defadvice ediff-buffers (around ediff-restore-windows activate)
  (setq ediff-last-windows (current-window-configuration))
  (add-hook 'ediff-after-quit-hook-internal 'ediff-restore-windows)
  ad-do-it)

(defun my/toggle-ediff-wide-display()
  "Turn off wide-display mode (if enabled) before quitting ediff."
  (interactive)
  (when ediff-wide-display-p
    (ediff-toggle-wide-display)))
(add-hook 'ediff-cleanup-hook
          (lambda ()
            (my/toggle-ediff-wide-display)
            (ediff-janitor t nil)
            ))

;; resume prior window configuration
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)

;; add a merge both command
(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff
   ediff-current-difference nil 'C nil
   (concat
    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun my/add-merge-to-ediff-mode-map ()
  "Add a `merge A and B to C' command to ediff."
  (define-key ediff-mode-map "c" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'my/add-merge-to-ediff-mode-map)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ediff-trees ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-prefix-command 'my/ediff-trees-keymap)
(use-package ediff-trees
  :bind (("C-c e" . my/ediff-trees-keymap)
         :map my/ediff-trees-keymap
         ("n" . ediff-trees-examine-next)
         ("p" . ediff-trees-examine-previous)
         ("C-n" . ediff-trees-examine-next-regexp)
         ("C-p" . ediff-trees-examine-previous-regexp)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; diff-hl ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "diff-hl/")))
(use-package  diff-hl-dired
  :init (add-hook 'dired-mode-hook 'diff-hl-dired-mode-unless-remote))
(use-package diff-hl
  :defer 2
  :config
  (use-package diff-hl-flydiff :config (diff-hl-flydiff-mode 1))
  (global-diff-hl-mode 1)
  ;; uncomment to use graphical display outside of terminal
  ;; (unless (display-graphic-p)
    (use-package diff-hl-margin :config (diff-hl-margin-mode 1))
    ;; )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; git-gutter ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package git-gutter
  :disabled t
  :init
  (setq git-gutter:hide-gutter t)
  (setq git-gutter:diff-option "-w")
  :config
  (global-git-gutter-mode 1)
  (setq git-gutter:update-interval 1)
  (git-gutter:start-update-timer)
  (global-set-key "\C-xvp" 'git-gutter:previous-hunk)
  (global-set-key "\C-xvn" 'git-gutter:next-hunk)
  (global-set-key "\C-xvd" 'git-gutter:popup-hunk)
  (global-set-key "\C-xvt" 'git-gutter:toggle)
  (global-set-key "\C-xvs" 'git-gutter:stage-hunk)
  (global-set-key "\C-xvr" 'git-gutter:revert-hunk)
  (global-set-key "\C-xvc" 'git-gutter:clear)
  (global-set-key "\C-xvu" 'git-gutter:update-all-windows)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; shebang ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package shebang)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; point-undo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package point-undo
  :bind (([?\C-,] . point-undo)
         ("M-' ," . point-undo)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; drag-stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  drag-stuff
  :defer 3
  :init
  (setq drag-stuff-modifier '(meta shift))
  :config
  (drag-stuff-global-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; framemove ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package framemove
  :config
  (use-package windmove)
  (windmove-default-keybindings)
  (setq framemove-hook-into-windmove t)
  ;;(setq windmove-wrap-around t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; frame-cmds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; this also loads 'frame-fns
(use-package frame-cmds
  :bind (([(meta up)]      . move-frame-up)
         ([(meta down)]    . move-frame-down)
         ([(meta left)]    . move-frame-left)
         ([(meta right)]   . move-frame-right)
         ([(meta shift ?v)]. move-frame-to-screen-top)
         ([(control shift ?v)] . move-frame-to-screen-bottom)
         ([(control shift prior)] . move-frame-to-screen-left)
         ([(control shift next)] . move-frame-to-screen-right)
         ([(control shift home)] . move-frame-to-screen-top-left)
         ([(control meta down)] . enlarge-frame)
         ([(control meta right)] . enlarge-frame-horizontally)
         ([(control meta up)] . shrink-frame)
         ([(control meta left)] . shrink-frame-horizontally)
         ([(control ?x) (control ?z)] . iconify-everything)
         ;; ([(control ?z)] . iconify/show-frame)
         ;; ([mode-line mouse-3] . mouse-iconify/show-frame)
         ;; ([mode-line C-mouse-3] . mouse-remove-window)
         ([(control meta ?z)] . show-hide)
         ;; ([vertical-line C-down-mouse-1] . show-hide)
         ;; ([C-down-mouse-1] . mouse-show-hide-mark-unmark)
         ("C-x t." . save-frame-config)
         ;; :map ctl-x-map
         ;; ("o" . other-window-or-frame)
         ;; :map ctl-x-4-map
         ;; ("1" . delete-other-frames)
         ;; :map ctl-x-5-map
         ;; ("h" . show-*Help*-buffer)
         )
  :commands remove-window
  :config
  (substitute-key-definition 'delete-window      'delete-windows-for global-map)
  (substitute-key-definition 'delete-window      'remove-window global-map)
  ;; disabling in favor of rotate
  ;;   (defun my/tile-frames-vertically()
  ;;     "Tile frames vertically. You can restore prior frame position via going to
  ;; register \\C-l."
  ;;     (interactive)
  ;;     (save-frame-config)
  ;;     (tile-frames-vertically))
  ;;   (defun my/tile-frames-horizontally()
  ;;     "Tile frames horizontally. You can restore prior frame position via going to
  ;; register \\C-l."
  ;;     (interactive)
  ;;     (save-frame-config)
  ;;     (tile-frames-horizontally))
  ;;   (bind-key "\e\ev" 'my/tile-frames-vertically)
  ;;   (bind-key "\e\eh" 'my/tile-frames-horizontally)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; workgroups ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package workgroups
  :demand t
  :bind (:map wg-map
              ("<left>" . wg-switch-left)
              ("<right>" . wg-switch-right)
              )
  :config
  (setq wg-default-buffer "*Bookmark List*")
  ;; doesn't work, isn't needed? (setq wg-restore-position t)
  ;; TODO: set initial string to "( -<{ }>- )"
  (setq wg-query-for-save-on-emacs-exit nil)
  (workgroups-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; workgroups2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'workgroups2)
;; (setq wg-prefix-key "\C-z")
;; ;; (define-key workgroups-mode-map (kbd "<left>") 'wg-switch-left)
;; ;; (define-key workgroups-mode-map (kbd "<right>") 'wg-switch-right)
;; (workgroups-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; color-theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "color-theme/"))
  (add-to-list 'load-path (concat my/plugins-directory "color-theme/themes/")))
(use-package color-theme
  :config
  (add-hook 'after-init-hook #'color-theme-initialize)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; palette ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package palette)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; smerge ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package smerge-mode
  :config
  (defun try-smerge()
    (save-excursion
      (goto-char (point-min))
      (smerge-mode
       (if (re-search-forward "^<<<<<<<" nil t) 1 0))))
  (add-hook 'find-file-hook 'try-smerge t)
  (add-hook 'after-save-hook (lambda() (if (smerge-mode) (try-smerge))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; multi-term ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package multi-term :commands multi-term)
                                        ;(setq multi-term-program "/bin/tcsh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; bash-completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package bash-completion
  :defer t
  :config
  (bash-completion-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; vlf ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "vlf/")))
(use-package vlf-setup
  :config
  (setq large-file-warning-threshold 100000000) ;100MB
  (setq vlf-batch-size 10000000)                ;10MB
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; profiles ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package profiles+
  :config
  (profile-define "default" "dharms" "danielrharms@gmail.com"
                  ;; relative path to makefiles
                  'build-sub-dirs '((""))
                  ;; relative path to debug executables (under project-root-dir
                  ;; and build-sub-dir)
                  ;; 'debug-sub-dirs '("tests/")
                  ;; specific compiler invocation command
                  'compile-sub-command "make"
                  )
  (profile-set-default "default")
  (global-set-key "\C-c0d" 'profile-open-dired-on-dir)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rtags ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "rtags/")))
(defvar rtags-exec (executable-find "rdm"))
(use-package rtags
  :disabled t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package custom-completion
  :init
  (setq tab-always-indent 'complete)      ;or t to avoid completion
  (add-to-list 'completion-styles 'initials t)
  (setq completion-auto-help nil)
  (setq completion-cycle-threshold t)     ;always cycle
  ;; Ignore case when completing file names
  (setq read-file-name-completion-ignore-case nil)
  :demand t
  :bind
  (("C-c C-r" . my/choose-choose-func)
   ("C-c C-e" . my/choose-completion)
   )
  :commands
  (my/activate-ido my/activate-ivy)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; auto-complete ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "auto-complete/")))
(use-package auto-complete
  :init
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
                                        ;(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  :config
  ;; user dictionary
  (add-to-list 'ac-user-dictionary-files
               (concat my/scratch-directory "user-dict"))
  ;; mode/extension directory (in addition to "plugins/auto-complete/dict")
  (add-to-list 'ac-dictionary-directories
               (concat my/scratch-directory "dict/"))
  (mapc (lambda(mode)
          (add-to-list 'ac-modes mode))
        '(sql-mode nxml-mode cmake-mode folio-mode protobuf-mode
                   python-mode dos-mode gud-mode sh-mode
                   makefile-mode makefile-automake-mode makefile-gmake-mode
                   autoconf-mode gdb-script-mode awk-mode csv-mode
                   mock-mode org-mode html-mode text-mode sql-mode
                   sql-interactive-mode conf-mode
                   git-commit-mode mock-mode
                   ))
  (use-package auto-complete-config)
  (setq-default ac-sources
                '(
                                        ;ac-source-yasnippet
                  ac-source-dictionary
                  ac-source-words-in-same-mode-buffers
                  ac-source-filename
                  ac-source-files-in-current-dir
                  ))
  (setq ac-expand-on-auto-complete nil)
  (setq ac-auto-start nil)
  (setq ac-dwim nil)
  (setq ac-use-menu-map t)
  (setq ac-ignore-case 'smart)
  (setq ac-menu-height 20)
  (global-auto-complete-mode t)

  (defun my/auto-complete-at-point ()
    (when (and (not (minibufferp))
               (fboundp 'auto-complete-mode)
               auto-complete-mode)
      #'auto-complete))

  (defun my/add-ac-completion-at-point ()
    (add-to-list 'completion-at-point-functions 'my/auto-complete-at-point))
  (add-hook 'auto-complete-mode-hook 'my/add-ac-completion-at-point)

  (ac-flyspell-workaround)

  ;; rtags
  (when rtags-exec
    (require 'rtags-ac)
    (setq rtags-completions-enabled t)
    (rtags-enable-standard-keybindings c-mode-base-map)
    (defun my/rtags-complete() (interactive)
           (auto-complete '(ac-source-rtags)))
    (global-set-key (kbd "\C-c r TAB") 'my/rtags-complete)
    )
  (use-package auto-complete-clang)
  (defvar clang-exec (executable-find "clang"))

  (use-package auto-complete-etags)
  (use-package auto-complete-nxml)
  ;; c-headers
  (use-package auto-complete-c-headers)
  (setq achead:include-patterns (list
                                 "\\.\\(h\\|hpp\\|hh\\|hxx\\|H\\)$"
                                 "/[a-zA-Z-_]+$"
                                 ))
  ;; doesn't work...
  ;; (setq achead:ac-prefix
  ;;       "#?\\(?:include\\|import\\)\\s-*[<\"]\\s-*\\([^\"<>' \t\r\n]+\\)")
  (setq achead:include-directories '("."))

  (add-hook 'c-mode-common-hook
            (lambda()
              (when rtags-exec
                (add-to-list 'ac-sources 'ac-source-rtags))
              (when clang-exec
                (define-key c-mode-base-map [?\M-/] 'ac-complete-clang)
                ;; (add-to-list 'ac-omni-completion-sources
                ;;              (cons "\\." '(ac-source-clang)))
                ;; (add-to-list 'ac-omni-completion-sources
                ;;              (cons "->" '(ac-source-clang)))
                )
              (add-to-list 'ac-sources 'ac-source-etags)
              (add-to-list 'ac-sources 'ac-source-c-headers)
              (setq c-tab-always-indent nil)
              (setq c-insert-tab-function 'indent-for-tab-command)
              ) t)                       ;append to hook list to take effect
                                        ;after ac-config-default
  (add-hook 'protobuf-mode-hook
            (lambda()(add-to-list 'ac-sources 'ac-source-etags)))
  (defun my/expand-imenu() (interactive)
         (auto-complete '(ac-source-imenu)))
  (global-set-key "\C-c0j" 'my/expand-imenu)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; YASnippet ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/plugins-directory "yasnippet/")))
(use-package yasnippet
  :init
  (add-to-list 'safe-local-variable-values '(require-final-newline . nil))
  (setq yas-snippet-dirs (list
                          (concat my/scratch-directory "snippets/")
                          ;; (concat my/plugins-directory "yasnippet/snippets/")
                          ))
  (setq yas-prompt-functions '(
                               yas-completing-prompt
                               yas-ido-prompt
                               yas-x-prompt
                               yas-dropdown-prompt
                               yas-no-prompt
                               ))
  (add-hook 'after-init-hook (lambda() (yas-global-mode 1)))
  :config
  (bind-keys
   :map yas-minor-mode-map
   ;; disable TAB key from activating a snippet
   ("<tab>" . nil)
   ("TAB" . nil)
   ;; add our own keybindings
   ("C-c se" . yas-expand)
   ("C-c si" . yas-insert-snippet)
   ("C-c sn" . yas-new-snippet)
   ("C-c sv" . yas-visit-snippet-file)
   ("C-c s?" . yas-describe-tables)
   )
  ;; integrate with auto-complete (shows only snippets)
  (defun my/expand-yasnippet() (interactive)
         (auto-complete '(ac-source-yasnippet)))
  (global-set-key [backtab] 'yas-expand)
  (global-set-key [(shift tab)] 'yas-expand)
  (setq yas-fallback-behavior '(apply my/expand-yasnippet))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; flycheck ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :init
  (setq flycheck-emacs-lisp-package-user-dir
        (concat my/user-directory "elpa/"))
  (add-hook 'flycheck-mode-hook #'flycheck-checkbashisms-setup)
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (setq flycheck-global-modes
        '(emacs-lisp-mode python-mode dart-mode sh-mode c++-mode))
  (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (use-package flycheck-checkbashisms)
  (use-package flycheck-pos-tip)
  (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
  (setq flycheck-pos-tip-display-errors-tty-function
        (lambda (errors)
          (let ((message (mapconcat #'flycheck-error-format-message-and-id
                                    errors "\n\n")))
            (popup-tip message))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; flyspell ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flyspell
  :if (executable-find "hunspell")
  :init
  (setq ispell-program-name (executable-find "hunspell"))
  :config
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  (define-key flyspell-mode-map [?\C-,] nil)
  (define-key flyspell-mode-map [?\C-\;] nil)
  (define-key flyspell-mode-map [?\C-\.] nil)
  (define-key flyspell-mode-map [?\C-\M-i] nil)
  (bind-keys
   :map flyspell-mode-map
   ("C-c \\c" . flyspell-auto-correct-word)
   ("C-c \\a" . flyspell-auto-correct-previous-word)
   ("C-c \\n" . flyspell-goto-next-error)
   ("C-c \\s" . flyspell-correct-word-before-point)
   ("C-c \\w" . ispell-word)
   ("C-c \\b" . flyspell-buffer)
   ("C-c \\r" . flyspell-region)
   )
  (use-package ace-popup-menu :config (ace-popup-menu-mode 1))
  (mapc (lambda (hook) (add-hook hook #'flyspell-mode))
        '(text-mode-hook markdown-mode org-mode))
  ;; (add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode)
  ;; (defun my/toggle-flyspell() (interactive)
  ;;        (lambda() (flyspell-mode (if flyspell-mode 0 1))))
  ;; (global-set-key "\C-c\\t" #'my/toggle-flyspell)
  )
(with-eval-after-load 'flyspell
  (require 'flyspell-popup)
  (bind-key "C-c \\\\" 'flyspell-popup-correct flyspell-mode-map))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; headers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; last modification time
(defun my/update-last-modifier ()
  "Update header line indicating identity of last modifier."
  (delete-and-forget-line)
  (insert (format " %s" (let ((name (user-full-name)))
                          (if (and name (not (string= name "")))
                              name
                            (user-login-name))))))
;; file name
(defun my/update-file-name ()
  "Update the line that indicates the file name."
  (beginning-of-line)
  ;; Verify looking at a file name for this mode.
  (when (looking-at (concat (regexp-quote (header-prefix-string)) " *\\([^ ]+\\) +\\-\\-"))
    (goto-char (match-beginning 1))
    (delete-region (match-beginning 1) (match-end 1))
    (insert (file-name-nondirectory (buffer-file-name)))))
(use-package header2
  :commands auto-update-file-header
  :init
  (add-hook 'write-file-functions 'auto-update-file-header)
  :config
  ;; use my own function, because delete-trailing-whitespace prevents a
  ;; space after the colon
  (register-file-header-action "Modified by[ \t]*:" 'my/update-last-modifier)
  (register-file-header-action "^[ \t]*.+ *\\([^ ]+\\) +\\-\\-" 'my/update-file-name)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; auto-insert ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package auto-insert-choose+
  :bind ("C-c st" . auto-insert)
  :demand t
  :init
  (setq auto-insert 'other)
  (setq auto-insert-directory (concat my/scratch-directory "auto-insert/"))
  ;; list of different templates to choose from
  ;; c++
  (defvar auto-insert-c-header-alist '())
  (defvar auto-insert-c-impl-alist '())
  ;; autoconf
  (defvar auto-insert-autoconf-alist '())
  ;; Makefile.am
  (defvar auto-insert-makefile-am-alist '())
  :config
  (auto-insert-choose+-add-entry 'auto-insert-c-header-alist "template.h")
  (auto-insert-choose+-add-entry 'auto-insert-c-impl-alist "template.cpp")
  (auto-insert-choose+-add-entry 'auto-insert-autoconf-alist
                                 "configure-standard.ac")
  (auto-insert-choose+-add-entry 'auto-insert-autoconf-alist
                                 "configure-library.ac")
  (auto-insert-choose+-add-entry 'auto-insert-makefile-am-alist
                                 "Makefile-toplevel.am")
  (auto-insert-choose+-add-entry 'auto-insert-makefile-am-alist
                                 "Makefile-library.am")
  (auto-insert-choose+-add-entry 'auto-insert-makefile-am-alist
                                 "Makefile-executable.am")
  ;; The "normal" entries (using auto-insert) can list the file name and
  ;; the yas-expand helper.  If you want to be able to choose among
  ;; different templates per mode or file extension, then use the
  ;; auto-insert-choose+ functionality: populate an alist per file type
  ;; with the different templates, then associate a lambda with a defun
  ;; that selects between them: completion, ido, popup.
  (setq auto-insert-alist
        '(
          ;; profiles
          (("\\.eprof$" . "Profiles") .
           ["template.eprof" auto-insert-choose-yas-expand])
          (("\\.rprof$" . "Remote Profiles") .
           ["template.rprof" auto-insert-choose-yas-expand])
          ;; lisp
          ((emacs-lisp-mode . "Emacs Lisp") .
           ["template.el" auto-insert-choose-yas-expand])
          ;; sh
          ((sh-mode . "Sh") .
           ["template.sh" auto-insert-choose-yas-expand])
          ;; dos
          ((dos-mode . "Dos") .
           ["template.bat" auto-insert-choose-yas-expand])
          ;; python
          ((python-mode . "Python") .
           ["template.py" auto-insert-choose-yas-expand])
          ;; CMake
          (("CMakeLists.txt" . "CMake") .
           ["template.cmake" auto-insert-choose-yas-expand])
          ;; autoconf
          ((autoconf-mode . "Autoconf")
           lambda nil (auto-insert-choose-and-call-popup
                       auto-insert-autoconf-alist))
          ;; makefile-automake
          ((makefile-automake-mode . "Makefile-Automake")
           lambda nil (auto-insert-choose-and-call-popup
                       auto-insert-makefile-am-alist))
          ;; c headers
          (("\\.\\(h\\|hh\\|H\\|hpp\\|hxx\\)$" . "c++")
           lambda nil (auto-insert-choose-and-call-popup
                       auto-insert-c-header-alist))
          ;; c impl
          (("\\.\\(cpp\\|cc\\|C\\|c\\|cxx\\)$" . "c++")
           lambda nil (auto-insert-choose-and-call-popup
                       auto-insert-c-impl-alist))
          ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; popup-kill-ring ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package popup-kill-ring :bind ("C-M-y" . popup-kill-ring))

;;;;;;;;;;;;;;;;;;;;;;;;;;; popup-global-mark-ring ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package popup-global-mark-ring :bind ("\e\ey" . popup-global-mark-ring))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; zop-to-char ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package zop-to-char
  :bind (("M-z" . zop-to-char)
         ("M-Z" . zop-up-to-char)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; speedbar ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'speedbar-mode-hook
          (lambda()
            (when (display-graphic-p)
              (setq-default gdb-speedbar-auto-raise t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; htmlize ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package htmlize
  :commands
  (htmlize-buffer htmlize-region htmlize-file htmlize-many-files
                  htmlize-many-files-dired))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; awk-it ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package awk-it
  :bind (("C-c 0aa" . awk-it)
         ("C-c 0ap" . awk-it-with-separator)
         ("C-c 0as" . awk-it-single)
         ("C-c 0ag" . awk-it-single-with-separator)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; list-environment ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package list-environment :bind ("C-c 0e" . list-environment))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; guide-key ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package guide-key
  :if (version< "24.3" emacs-version)
  :disabled t
  :config
  (guide-key-mode 1)
  )


(add-hook 'before-save-hook 'my/before-save-hook)
(defun my/before-save-hook() "Presave hook"
       (when (memq major-mode
                   '(c++-mode
                     emacs-lisp-mode
                     perl-mode
                     java-mode
                     python-mode
                     dos-mode
                     nxml-mode
                     protobuf-mode
                     dart-mode
                     folio-mode
                     markdown-mode
                     sh-mode
                     csharp-mode
                     awk-mode
                     sed-mode
                     gdb-script-mode
                     gitignore-mode
                     gitconfig-mode
                     gitattributes-mode
                     ))
         (delete-trailing-whitespace)
         (copyright-update nil t)
         (time-stamp)
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; os ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let* ((system-file (concat my/os-dir my/system-name)))
  ;; load os file
  (load system-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; gui ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((gui window-system)
      gui-file)
  ;; load gui file
  (setq gui-file (concat my/gui-dir (if (null gui) "tty" (symbol-name gui))))
  (load gui-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; site ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/load-site-file (name)
  "Load a site file associated with site NAME, and perform related
customization."
  (let* ((site-dir
          (file-name-as-directory
           (concat my/user-directory "settings/site/" name)))
         (site-file (concat site-dir name)))
    (when (file-exists-p site-file)
      ;; (setq site-name (file-name-base site-file))
      (load site-file))
    (setq yas-snippet-dirs (cons (concat site-dir "snippets/")
                                 yas-snippet-dirs))
    (when (fboundp 'yas-reload-all) (yas-reload-all))
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; host ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my/host-plist '())
(let* ((system system-name)
       (hosts-dir (concat my/user-directory "settings/host/"))
       (hosts-file (concat hosts-dir "hosts"))
       (host-dir
        (file-name-as-directory
         (concat hosts-dir system)))
       (host-file (concat host-dir system)))
  ;; store location of remote hosts file for later
  (setq my/remote-hosts-file (concat my/user-directory "remote-hosts"))
  ;; load host file (if present)
  (if (file-exists-p host-file)
      (progn
        (load host-file t))
    ;; otherwise look for current host in hosts file
    (load hosts-file t)
    (mapc
     (lambda(plist)
       (and (string= (plist-get plist :host) system)
            (plist-get plist :site)
            (my/load-site-file (plist-get plist :site))))
     my/host-plist))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; modes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (append '(("\\.C$"        . c++-mode)
                ("\\.cc$"       . c++-mode)
                ("\\.cpp$"      . c++-mode)
                ("\\.inl$"      . c++-mode)
                ("\\.c$"        . c++-mode)
                ("\\.H$"        . c++-mode)
                ("\\.hh$"       . c++-mode)
                ("\\.hpp$"      . c++-mode)
                ("\\.h$"        . c++-mode)
                ("\\.java$"     . java-mode)
                ("\\.pl$"       . perl-mode)
                ("\\.pm$"       . perl-mode)
                ("SConstruct"   . python-mode)
                ("SConscript"   . python-mode)
                ("\\.otq$"      . conf-mode) ;one-tick-query files
                ("\\.bmk$"      . emacs-lisp-mode)
                )
              auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; awk-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'awk-mode-hook
          (lambda()
            (setq comment-start "#") (setq comment-end "")
            (define-key awk-mode-map "\C-c\C-c" 'comment-region)
            (define-key awk-mode-map "\C-c\C-u" 'uncomment-region)
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; cask-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cask-mode
  :mode "/Cask\\'"
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; conf-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'conf-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)
            (subword-mode 1)
            ;; (idle-highlight-mode 1)
            ;; conf-colon-mode still bound to "\C-c:"
            (local-unset-key "\C-c\C-c")
            ;; conf-unix-mode now bound to "\C-cu"
            (local-unset-key "\C-c\C-u")
            (define-key conf-mode-map "\C-cu" 'conf-unix-mode)
            (define-key conf-mode-map "\C-c\C-c" 'comment-region)
            (define-key conf-mode-map "\C-c\C-u" 'uncomment-region)
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; cmake-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  cmake-mode
  :mode ("CMakeLists\\.txt$" "\\.cmake$")
  :config
  (use-package cmake-font-lock)
  (defun my/cmake-fix-underscore()
    (modify-syntax-entry ?_ "_" cmake-mode-syntax-table))
  (add-hook 'cmake-mode-hook #'my/cmake-fix-underscore)
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; css-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'css-mode-hook
          (lambda()
            (if (featurep 'rainbow-mode)
                (rainbow-turn-on)
              (my/syntax-color-hex-values))
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; csv-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package csv-mode :mode ("\\.[Cc][Ss][Vv]$" . csv-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; dart-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dart-mode :mode "\\.dart$" :interpreter "dart"
  :init
  (setq dart-enable-analysis-server t)
  :config
  (add-hook 'dart-mode
            (lambda()
              (define-key dart-mode-map "\C-c\C-c" 'comment-region)
              (define-key dart-mode-map "\C-c\C-u" 'uncomment-region)
              )))
;not sure this is needed (add-hook 'dart-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; dos-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package dos :mode ("\\.bat$" . dos-mode)
  :config
  (use-package dos-indent)
  (add-hook 'dos-mode-hook
            (lambda()
              (setq-default indent-tabs-mode nil)
              ;; (idle-highlight-mode 1)
              (define-key dos-mode-map "\r" 'reindent-then-newline-and-indent)
              (setq dos-basic-offset 3)
              (setq dos-indentation 3)
              (define-key dos-mode-map "\C-c\C-c" 'comment-region)
              (define-key dos-mode-map "\C-c\C-u" 'uncomment-region)
              )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; emacs-lisp-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)
            (define-key emacs-lisp-mode-map "\r" 'reindent-then-newline-and-indent)
            (define-key emacs-lisp-mode-map "\C-c\C-c" 'comment-region)
            (define-key emacs-lisp-mode-map "\C-c\C-u" 'uncomment-region)
            (define-key emacs-lisp-mode-map (kbd "\C-c RET")
              (lambda()(interactive)
                (byte-compile-file (buffer-file-name))))
            (if (featurep 'rainbow-mode)
                (rainbow-turn-on)
              (my/syntax-color-hex-values))
            ))
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(require 'lisp-extra-font-lock)
(lisp-extra-font-lock-global-mode 1)
(add-hook 'after-save-hook
          (lambda()
            (require 'bytecomp)
            (when (and
                   (eq major-mode 'emacs-lisp-mode)
                   (file-exists-p (byte-compile-dest-file (buffer-file-name)))
                   (not (string-match
                         "^\\.dir-locals.el$"
                         (file-name-nondirectory
                          (buffer-file-name)))))
              (save-excursion
                (byte-compile-file buffer-file-name)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; folio-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package folio-mode :mode "\\.folio$"
  :config (use-package folio-electric))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; git-modes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package gitignore-mode
  :mode ("/\\.gitignore\\'"
         "/info/exclude\\'"
         "/git/ignore\\'"))
(use-package gitconfig-mode
  :mode ("/\\.gitconfig\\'"      "/\\.git/config\\'"
         "/modules/.*/config\\'" "/git/config\\'"
         "/\\.gitmodules\\'"     "/etc/gitconfig\\'"))
(use-package gitattributes-mode
  :mode ("/\\.gitattributes\\'"
         "/info/attributes\\'"
         "/git/attributes\\'"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; html-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'html-mode-hook
          (lambda()
            (if (featurep 'rainbow-mode)
                (rainbow-turn-on)
              (my/syntax-color-hex-values))
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; json-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package json-mode
  :mode "\\.json$"
  :if (version< emacs-version "23")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; log-viewer-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package log-viewer :mode ("\\.log$" . log-viewer-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; markdown-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :mode ("\\.md$" "\\.markdown$"
         "LICENSE$" "README$" "INSTALL$" "CONTRIBUTORS$" "COPYING$"
         )
  :init
  (add-hook 'markdown-mode-hook #'my/set-word-processor)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; nhexl-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package nhexl-mode :defer t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; python-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-and-compile
  (add-to-list 'load-path (concat my/elisp-directory "emacs-jedi/")))
(use-package python
  :if (executable-find "python")
  :defer t
  :config
  (use-package virtualenvwrapper)
                                        ;(setq venv-location "?")
  ;; add jedi if installed
  (when (eq 0 (call-process "python" nil nil nil "-c" "import jedi"))
                                        ;      (setq jedi:setup-keys t)
    (setq jedi:complete-on-dot t)
    (setq jedi:tooltip-method '(popup))
    (use-package jedi)
    (use-package direx)
    (use-package jedi-direx)
    (add-hook 'jedi-mode-hook 'jedi-direx:setup)
    (add-hook 'python-mode-hook 'jedi:setup)
    (defun my/expand-jedi() (interactive)
           (auto-complete '(ac-source-jedi-direct)))
    )
  (unless (executable-find "flake8")
    (add-to-list 'flycheck-disabled-checkers 'python-flake8)
    (add-to-list 'flycheck-checkers 'python-pyflakes)
    (use-package flycheck-pyflakes)
    )
  (add-hook 'python-mode-hook
            (lambda()
              (setq-default indent-tabs-mode nil)
              (setq python-indent-guess-indent-offset nil)
              (setq python-indent-offset 4)
              (setq-local electric-indent-chars
                          (remq ?: electric-indent-chars))
              (setq forward-sexp-function nil)
              (define-key python-mode-map "\C-j" 'newline-and-indent)
              (define-key python-mode-map "\C-c\C-c" 'comment-region)
              (define-key python-mode-map "\C-c\C-u" 'uncomment-region)
              (define-key python-mode-map [?\C-\M-g] 'python-nav-forward-sexp)
              (define-key python-mode-map (kbd "\C-c RET")
                (lambda()(interactive)
                  (compile (concat "python " (buffer-file-name)))))
              (when (featurep 'jedi)
                (define-key python-mode-map [(ctrl tab)] 'my/expand-jedi)
                (define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))
              )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; qt-pro-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package qt-pro :mode "\\.pro$")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sed-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package sed-mode :mode "\\.sed$" :interpreter "sed")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sh-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'sh-mode-hook
          (lambda()
            (setq-default indent-tabs-mode nil)
            ;; (idle-highlight-mode 1)
            (define-key sh-mode-map "\r" 'reindent-then-newline-and-indent)
            (setq sh-basic-offset 3)
            (setq sh-indentation 3)
            (define-key sh-mode-map "\C-c\C-c" 'comment-region)
            (define-key sh-mode-map "\C-c\C-u" 'uncomment-region)
            (add-to-list 'flycheck-disabled-checkers 'sh-posix-dash)
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; text-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'text-mode-hook #'my/set-word-processor)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; xml-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'nxml-mode-hook
          (lambda()
            (setq-default indent-tabs-mode nil)
            ;; (idle-highlight-mode 1)
            (define-key nxml-mode-map "\r" 'reindent-then-newline-and-indent)
            (define-key nxml-mode-map "\C-c\C-c" 'comment-region)
            (define-key nxml-mode-map "\C-c\C-u" 'uncomment-region)
            ))
(require 'mz-comment-fix)
;; the following is a hack to fix nested XML commenting in Emacs 24.
;; Note that 'comment-strip-start-length also exists for other modes if needed.
(add-to-list 'comment-strip-start-length (cons 'nxml-mode 3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; yaml-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yaml-mode
  :mode ("\\.yaml$" "\\.yml$")
  :config
  (defun yaml-next-field() "Jump to next yaml field."
         (interactive)
         (search-forward-regexp ": *"))
  (defun yaml-prev-field() "Jump to previous yaml field."
         (interactive)
         (search-backward-regexp ": *"))
  (add-hook 'yaml-mode-hook
            (lambda()
              (define-key yaml-mode-map "\C-m" 'newline-and-indent)
              (define-key yaml-mode-map "\M-\r" 'insert-ts)
              (define-key yaml-mode-map (kbd "C-<tab>") 'yaml-next-field)
              (define-key yaml-mode-map (kbd "C-S-<tab>") 'yaml-prev-field)
              )))

;; code ends here
