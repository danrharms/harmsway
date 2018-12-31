;;; nimbus-theme.el --- An awesome dark theme
;;
;; Filename:    nimbus-theme.el
;; Description: An awesome dark theme
;; Author:      Marcin Swieczkowski <marcin.swieczkowski@gmail.com>
;;              See README.md for full list of contributors.
;; Created:     Thu Mar 2 22:19:19 CET 2017
;; Version:     1.0.0
;; URL:         https://github.com/m-cat/nimbus-theme
;; Keywords:    faces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; About:
;;
;; The best dark theme for Emacs.
;;
;; See README.md for more info.
;;
;; Installing:
;;
;; See README.md for the most up-to-date installation instructions.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(deftheme nimbus "An awesome dark theme.")

;; Define the palette.
(let (
      (lightest-green "#8fbc8f")
      (light-green    "#9ccc65")
      (green          "#6aaf50")
      (dark-green     "#36a06a")
      (darker-green   "#058945")
      (green-bg       "#11472b")
      (lightest-blue  "#86b5e8")
      (light-blue     "#68a5e9")
      (blue           "#598bc1")
      (blue-bg        "#112b47")
      (orange         "#df9522")
      (tan            "#bdbc61")
      (dark-tan       "#7d7c61")
      (bright-yellow  "#fffe0a")
      (yellow         "#baba36")
      (purple         "#ab75c3")
      (light-gray     "#858585")
      (gray           "#757575")
      (dark-gray      "#656565")
      (darker-gray    "#454545")
      (darkest-gray   "#353535")
      (blue-gray      "#608079")
      (brown          "#987654")
      (red            "#d65946")
      (dark-red       "#9d2512")
      (red-bg         "#47112b")
      (white          "white")
      (black          "black")

      (cursor         "#f57e00")
      (fringe         "gray10")

      (bg             "gray10")
      (fg             "#bdbdb3")
      )

  ;; Set faces.
  (custom-theme-set-faces
   `nimbus ;; You must use the same theme name here...
   `(default
      ((t (:foreground ,fg :background ,bg :bold nil))))
   `(cursor       ((t (:foreground ,black :background ,cursor))))
   `(fringe       ((t (:background ,fringe  :bold nil :underline nil))))
   `(link         ((t (:foreground ,lightest-blue :underline t))))
   `(link-visited ((t (:foreground ,blue-gray :underline t))))
   `(highlight
     ((t (:background ,red-bg))))
   `(region
     ((t (:background ,green-bg))))
   `(shadow       ((t (:foreground ,light-gray))))
   `(tooltip      ((t (:background ,fg :foreground ,bg))))

   ;; standard font lock
   `(font-lock-builtin-face           ((t (:foreground ,blue))))
   `(font-lock-comment-face
     ((t (:foreground ,light-gray :slant italic))))
   `(font-lock-comment-delimiter-face
     ((t (:inherit font-lock-comment-face))))
   `(font-lock-function-name-face     ((t (:foreground ,dark-green))))
   `(font-lock-keyword-face           ((t (:foreground ,blue))))
   `(font-lock-string-face            ((t (:foreground ,green))))
   `(font-lock-preprocessor-face      ((t (:foreground ,orange))))
   `(font-lock-type-face              ((t (:foreground ,red))))
   `(font-lock-constant-face          ((t (:foreground ,purple))))
   `(font-lock-warning-face
     ((t (:foreground ,orange :bold t))))
   `(font-lock-variable-name-face     ((t (:foreground ,yellow))))
   `(font-lock-doc-face
     ((t (:inherit font-lock-comment-face :foreground ,lightest-green))))

   ;; highlight-numbers
   `(highlight-numbers-number
     ((t (:foreground ,orange))))
   ;; highlight-quoted
   `(highlight-quoted-symbol
     ((t (:foreground ,green))))
   ;; highlight-operators
   `(highlight-operators-face
     ((t (:foreground ,darker-green))))

   ;; search
   `(isearch
     ((t (:foreground ,black :background ,dark-green))))
   `(lazy-highlight
     ((t (:foreground ,black :background ,red))))

   ;; mode line & powerline
   `(powerline-active1
     ((t (:foreground ,fg :background ,darkest-gray))))
   `(powerline-active2
     ((t (:foreground ,black :background ,dark-green))))
   `(powerline-inactive1
     ((t (:foreground ,dark-gray :background ,bg))))
   `(powerline-inactive2
     ((t (:foreground ,black :background ,gray))))
   `(mode-line
     ((t (:foreground ,black :background ,darker-green))))
   `(mode-line-inactive
     ((t (:foreground ,black :background ,blue-gray))))

   ;; ace-jump mode
   `(ace-jump-face-background ((t (:inherit font-lock-comment-face))))
   `(ace-jump-face-foreground ((t (:foreground ,orange))))

   ;; ace-window
   `(aw-background-face ((t (:foreground ,dark-gray))))
   `(aw-leading-char-face
     ((t (:foreground ,black :background ,dark-green))))

   ;; anzu mode
   `(anzu-match-1
     ((t (:inherit isearch))))
   `(anzu-match-2
     ((t (:foreground ,white :background ,yellow))))
   `(anzu-match-3
     ((t (:inherit lazy-highlight))))
   `(anzu-mode-line
     ((t (:foreground ,white :background ,bg :bold nil))))
   `(anzu-mode-line-no-match
     ((t (:foreground ,red :background ,bg :bold nil))))
   `(anzu-replace-to
     ((t (:foreground ,yellow))))

   ;; avy, colors chosen for good contrast
   `(avy-background-face
     ((t (:foreground ,light-gray))))
   `(avy-lead-face
     ((t (:foreground ,black :bold nil :slant normal :underline nil :background ,green))))
   `(avy-lead-face-0
     ((t (:inherit avy-lead-face :background ,red))))
   `(avy-lead-face-1
     ((t (:inherit avy-lead-face :background ,fg))))
   `(avy-lead-face-2
     ((t (:inherit avy-lead-face :background ,white))))
   `(avy-goto-char-timer-face
     ((t (:inherit avy-lead-face :background ,dark-green))))

   ;; cargo
   `(cargo-process--ok-face
     ((t (:foreground ,green))))
   `(cargo-process--errno-face
     ((t (:inherit link))))
   `(cargo-process--error-face
     ((t (:inherit error))))
   `(cargo-process--pointer-face
     ((t (:foreground ,purple))))
   `(cargo-process--warning-face
     ((t (:foreground ,orange))))
   `(cargo-process--standard-face
     ((t (:foreground ,yellow))))

   ;; line numbers
   `(linum
     ((t (:inherit fringe :foreground ,blue-gray :slant normal))))
   `(nlinum-current-line
     ((t (:inherit linum :foreground ,dark-green))))

   `(popup-tip-face ((t (:background ,fg :foreground ,bg))))

   `(header-line
     ((t (:background ,darker-gray :foreground ,fg))))

   ;; which-func mode
   `(which-func
     ((t (:foreground ,black))))

   `(button
     ((t (:foreground ,light-blue  :underline t))))

   ;; re-builder
   `(reb-match-0
     ((t (:foreground ,black :background ,red))))
   `(reb-match-1
     ((t (:foreground ,black :background ,green))))
   `(reb-match-2
     ((t (:foreground ,black :background ,yellow))))
   `(reb-match-3
     ((t (:foreground ,black :background ,blue))))

   ;; evil-search-highlight-persist
   `(evil-search-highlight-persist-highlight-face
     ((t (:background ,blue :foreground ,bg))))

   ;; vertical border between windows
   `(vertical-border
     ((t (:foreground ,darker-gray))))

   ;; hl-line-mode
   `(hl-line ((t (:background ,blue-bg))))

   `(secondary-selection
     ((t (:inherit highlight))))

   ;; ruler
   `(ruler-mode-default
     ((t (:background ,darker-gray :foreground ,fg))))
   `(ruler-mode-column-number  ((t (:inherit font-lock-constant-face))))
   `(ruler-mode-comment-column ((t (:foreground ,red))))
   `(ruler-mode-current-column ((t (:foreground ,yellow :weight bold))))
   `(ruler-mode-fill-column    ((t (:foreground ,red))))
   `(ruler-mode-fringes        ((t (:foreground ,green))))
   `(ruler-mode-goal-column    ((t (:foreground ,red))))
   `(ruler-mode-margins        ((t (:foreground ,white))))
   `(ruler-mode-pad            ((t (:foreground ,lightest-green))))
   `(ruler-mode-tab-stop       ((t (:foreground ,blue))))

   ;; volatile-highlights
   `(vh1/default-face ((t (:background ,green))))

   ;; mini buffer
   `(minibuffer-prompt ((t (:bold t))))

   ;; compile
   `(compilation-info
     ((t (:foreground ,dark-green :bold t))))
   `(compilation-warning
     ((t (:foreground ,orange :bold t :background ,bg))))
   `(compilation-error
     ((t (:inherit error :bold t))))
   `(compilation-mode-line-exit
     ((t (:inherit compilation-info :background ,bg))))
   `(compilation-mode-line-run
     ((t (:inherit compilation-warning :background ,bg))))
   `(compilation-mode-line-fail
     ((t (:inherit compilation-error :foreground ,dark-red :background ,bg))))

   ;; dired+
   `(diredp-autofile-name
     ((t (:background ,blue-bg))))
   `(diredp-compressed-file-name
     ((t (:foreground ,blue))))
   `(diredp-compressed-file-suffix
     ((t (:foreground ,blue))))
   `(diredp-date-time
     ((t (:foreground ,light-blue))))
   `(diredp-deletion
     ((t (:foreground ,bright-yellow :background ,red))))
   `(diredp-deletion-file-name
     ((t (:foreground ,red))))
   `(diredp-dir-heading
     ((t (:foreground ,yellow :background ,darker-gray))))
   `(diredp-dir-name
     ((t (:foreground ,dark-green))))
   `(diredp-dir-priv
     ((t (:foreground ,white :background ,dark-green))))
   `(diredp-exec-priv
     ((t (:foreground ,white :background ,dark-red))))
   `(diredp-executable-tag
     ((t (:foreground ,red))))
   `(diredp-file-name
     ((t (:foreground ,yellow))))
   `(diredp-file-suffix
     ((t (:foreground ,tan))))
   `(diredp-flag-mark
     ((t (:foreground ,blue-bg :background ,orange))))
   `(diredp-flag-mark-line
     ((t (:inherit highlight))))
   `(diredp-ignored-file-name
     ((t (:foreground ,light-gray))))
   `(diredp-link-priv
     ((t (:foreground ,light-blue))))
   `(diredp-mode-line-flagged
     ((t (:foreground ,red))))
   `(diredp-mode-line-marked
     ((t (:foreground ,purple))))
   `(diredp-no-priv
     ((t (:background ,blue-bg))))
   `(diredp-number
     ((t (:foreground ,yellow))))
   `(diredp-other-priv
     ((t (:background ,purple))))
   `(diredp-rare-priv
     ((t (:foreground ,green :background ,darker-gray))))
   `(diredp-read-priv
     ((t (:foreground ,white :background ,darker-gray))))
   `(diredp-symlink
     ((t (:foreground ,purple))))
   `(diredp-tagged-autofile-name
     ((t (:background ,blue-bg))))
   `(diredp-write-priv
     ((t (:foreground ,white :background ,dark-tan))))

   ;; eshell
   `(eshell-prompt        ((t (:foreground ,purple))))
   `(eshell-ls-directory  ((t (:inherit font-lock-function-name-face))))
   `(eshell-ls-product    ((t (:foreground ,orange))))
   `(eshell-ls-backup     ((t (:foreground ,dark-gray))))
   `(eshell-ls-executable ((t (:inherit font-lock-keyword-face))))

   ;; Eyebrowse
   `(eyebrowse-mode-line-inactive ((t (:foreground ,darkest-gray))))

   ;; shell
   `(comint-highlight-prompt ((t (:foreground ,green))))

   ;; term
   `(term-color-black
     ((t (:foreground ,darkest-gray :background ,darkest-gray))))
   `(term-color-red
     ((t (:foreground ,red :background ,red))))
   `(term-color-green
     ((t (:foreground ,green :background ,green))))
   `(term-color-yellow
     ((t (:foreground ,yellow :background ,yellow))))
   `(term-color-blue
     ((t (:foreground ,blue :background ,blue))))
   `(term-color-magenta
     ((t (:foreground ,purple :background ,purple))))
   `(term-color-cyan
     ((t (:foreground ,light-blue :background ,light-blue))))
   `(term-color-white
     ((t (:foreground ,fg :background ,fg))))
   `(term-default-fg-color ((t (:inherit fg))))
   `(term-default-bg-color ((t (:inherit bg))))

   ;; Flycheck
   `(flycheck-info
     ((t (:underline (:style wave :color ,green)))))
   ;; `(flycheck-error
   ;;   ((t ())))
   ;; `(flycheck-warning
   ;;   ((t ())))
   `(flycheck-fringe-info
     ((t (:foreground ,green))))
   ;; `(flycheck-fringe-warning
   ;;   ((t ())))
   ;; `(flycheck-fringe-error
   ;;   ((t (:inherit error))))
   ;; `(flycheck-error-list-id
   ;;   ((t ())))
   `(flycheck-error-list-info
     ((t (:foreground ,green))))
   ;; `(flycheck-error-list-error
   ;;   ((t ())))
   ;; `(flycheck-error-list-warning
   ;;   ((t ())))
   ;; `(flycheck-error-list-highlight
   ;;   ((t ())))
   ;; `(flycheck-error-list-line-number
   ;;   ((t ())))
   `(flycheck-error-list-checker-name
     ((t (:foreground ,yellow))))
   ;; `(flycheck-error-list-column-number
   ;;   ((t ())))
   ;; `(flycheck-error-list-id-with-explainer
   ;;   ((t ())))

   ;; geiser
   `(geiser-font-lock-autodoc-current-arg
     ((t (:foreground ,tan))))
   `(geiser-font-lock-autodoc-identifier
     ((t (:foreground ,blue))))
   `(geiser-font-lock-doc-link
     ((t (:foreground ,lightest-green :underline t))))
   `(geiser-font-lock-error-link
     ((t (:foreground ,lightest-green :underline t))))
   `(geiser-font-lock-xref-link
     ((t (:foreground ,lightest-green :underline t))))

   ;; slime
   `(slime-error-face
     ((t (:underline (:style wave :color ,red)))))
   `(slime-note-face
     ((t (:underline (:style wave :color ,blue)))))
   `(slime-style-warning-face
     ((t (:underline (:style wave :color ,bright-yellow)))))
   `(slime-warning-face
     ((t (:underline (:style wave :color ,orange)))))
   `(sldb-restartable-frame-line-face
     ((t (:foreground ,green))))
   `(slime-repl-inputed-output-face
     ((t (:foreground ,red))))

   ;; erc
   `(erc-nick-default-face ((t (:foreground ,blue))))
   `(erc-my-nick-face      ((t (:foreground ,yellow))))
   `(erc-current-nick-face ((t (:foreground ,blue))))
   `(erc-notice-face       ((t (:foreground ,green))))
   `(erc-input-face        ((t (:foreground ,white))))
   `(erc-timestamp-face    ((t (:foreground ,darker-gray))))
   `(erc-prompt-face       ((t (:foreground ,purple))))
   `(erc-keyword-face      ((t (:foreground, light-green :bold t))))

   ;; rcirc
   `(rcirc-bright-nick     ((t (:foreground ,white))))
   `(rcirc-my-nick         ((t (:foreground ,yellow))))
   `(rcirc-nick-in-message ((t (:inherit rcirc-my-nick))))
   `(rcirc-other-nick      ((t (:foreground ,blue))))
   `(rcirc-server          ((t (:foreground ,green))))
   `(rcirc-timestamp       ((t (:foreground ,darker-gray))))
   `(rcirc-prompt
     ((t (:foreground "#191919" :background ,purple))))

   ;;undo-tree
   `(undo-tree-visualizer-active-branch-face ((t (:inherit default))))
   `(undo-tree-visualizer-default-face
     ((t (:inherit font-lock-comment-face))))
   `(undo-tree-visualizer-register-face
     ((t (:foreground ,yellow))))
   `(undo-tree-visualizer-current-face
     ((t (:foreground ,red))))
   `(undo-tree-visualizer-unmodified-face
     ((t (:foreground ,purple))))

   ;;show paren
   `(show-paren-match
     ((t (:foreground ,white))))
   `(show-paren-mismatch ((t (:inherit error))))

   ;; error
   `(error ((t (:foreground "red"))))

   ;; ido
   `(ido-only-match         ((t (:foreground ,green))))
   `(ido-first-match        ((t (:foreground ,blue))))
   `(ido-incomplete-regexp  ((t (:foreground ,red))))
   `(ido-subdir             ((t (:foreground ,yellow))))
   ;; flx-ido
   `(flx-highlight-face
     ((t (:foreground ,light-blue  :underline nil :bold t))))

   ;;js2
   `(js2-external-variable
     ((t (:foreground ,orange))))
   `(js2-function-param
     ((t (:foreground ,dark-green))))
   `(js2-instance-member
     ((t (:foreground ,purple))))
   `(js2-jsdoc-html-tag-delimiter
     ((t (:foreground ,gray))))
   `(js2-jsdoc-html-tag-name
     ((t (:foreground ,gray))))
   `(js2-jsdoc-tag
     ((t (:foreground ,blue))))
   `(js2-jsdoc-type
     ((t (:foreground ,red))))
   `(js2-jsdoc-value
     ((t (:foreground ,yellow))))
   `(js2-private-function-call
     ((t (:foreground ,dark-green))))
   `(js2-private-member
     ((t (:foreground ,dark-tan))))
   `(js2-warning
     ((t ( :underline ,orange))))

   ;;web-mode
   `(web-mode-block-attr-name-face
     ((t (:foreground "#8fbc8f"))))
   `(web-mode-block-attr-value-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-block-comment-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-block-control-face
     ((t (:inherit font-lock-preprocessor-face))))
   `(web-mode-block-delimiter-face
     ((t (:inherit font-lock-preprocessor-face))))
   `(web-mode-block-face
     ((t (:background "LightYellow1"))))
   `(web-mode-block-string-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-builtin-face
     ((t (:inherit font-lock-builtin-face))))
   `(web-mode-comment-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-comment-keyword-face
     ((t (:bold t))))
   `(web-mode-constant-face
     ((t (:foreground ,purple))))
   `(web-mode-css-at-rule-face
     ((t (:foreground ,purple))))
   `(web-mode-css-color-face
     ((t (:foreground ,blue))))
   `(web-mode-css-comment-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-css-function-face
     ((t (:foreground ,blue))))
   `(web-mode-css-priority-face
     ((t (:foreground ,blue))))
   `(web-mode-css-property-name-face
     ((t (:inherit font-lock-variable-name-face))))
   `(web-mode-css-pseudo-class-face
     ((t (:foreground ,blue))))
   `(web-mode-css-selector-face
     ((t (:foreground ,blue))))
   `(web-mode-css-string-face
     ((t (:foreground ,tan))))
   `(web-mode-current-element-highlight-face
     ((t (:background "#000000"))))
   `(web-mode-doctype-face
     ((t (:inherit font-lock-doc-face))))
   `(web-mode-error-face
     ((t (:inherit error))))
   `(web-mode-folded-face
     ((t (:underline t))))
   `(web-mode-function-call-face
     ((t (:inherit font-lock-function-name-face))))
   `(web-mode-function-name-face
     ((t (:inherit font-lock-function-name-face))))
   `(web-mode-html-attr-custom-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-html-attr-equal-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-html-attr-name-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-html-attr-value-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-html-tag-bracket-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-html-tag-custom-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-html-tag-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-javascript-comment-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-javascript-string-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-json-comment-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-json-context-face
     ((t (:foreground "orchid3"))))
   `(web-mode-json-key-face
     ((t (:foreground "plum"))))
   `(web-mode-json-string-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-keyword-face
     ((t (:inherit font-lock-keyword-face))))
   `(web-mode-param-name-face
     ((t (:foreground "Snow3"))))
   `(web-mode-part-comment-face
     ((t (:inherit font-lock-comment-face))))
   `(web-mode-part-face
     ((t (:background "LightYellow1"))))
   `(web-mode-part-string-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-preprocessor-face
     ((t (:inherit font-lock-preprocessor-face))))
   `(web-mode-string-face
     ((t (:inherit font-lock-string-face))))
   `(web-mode-symbol-face
     ((t (:foreground "gold"))))
   `(web-mode-type-face
     ((t (:inherit font-lock-type-face))))
   `(web-mode-variable-name-face
     ((t (:inherit font-lock-variable-name-face))))
   `(web-mode-warning-face
     ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespace-face
     ((t (:background "DarkOrchid4"))))

   ;; package.el
   `(package-name
     ((t (:foreground ,lightest-blue :underline t))))
   `(package-status-available ((t (:foreground ,green))))
   `(package-description      ((t (:foreground ,yellow))))

   ;; helm
   `(helm-M-x-key
     ((t (:foreground ,orange :underline nil))))
   `(helm-action
     ((t (:foreground ,yellow :underline nil))))
   `(helm-bookmark-addressbook   ((t (:foreground ,red))))
   ;;`(helm-bookmark-directory   ((t ())))
   `(helm-bookmark-file          ((t (:foreground ,light-blue))))
   `(helm-bookmark-gnus          ((t (:foreground ,purple))))
   `(helm-bookmark-info          ((t (:foreground ,green))))
   `(helm-bookmark-man           ((t (:foreground ,orange))))
   `(helm-bookmark-w3m           ((t (:foreground ,yellow))))
   `(helm-buffer-directory       ((t (:foreground ,green))))
   ;; `(helm-buffer-not-saved       ((t (:inherit italics))))
   `(helm-buffer-process         ((t (:foreground ,green))))
   ;;`(helm-buffer-saved-out     ((t ())))
   `(helm-buffer-size            ((t (:foreground ,yellow))))
   `(helm-candidate-number
     ((t (:foreground ,green :background ,blue-bg))))
   `(helm-ff-directory           ((t (:foreground ,blue))))
   `(helm-ff-executable          ((t (:foreground ,green))))
   `(helm-ff-file
     ((t (:foreground ,purple :inherit default))))
   ;;`(helm-ff-invalid-symlink   ((t ())))
   `(helm-ff-prefix              ((t (:foreground ,red))))
   ;;`(helm-ff-symlink           ((t ())))
   ;;`(helm-grep-cmd-line        ((t ())))
   `(helm-grep-file
     ((t (:foreground ,purple :underline t))))
   `(helm-grep-finish            ((t (:foreground ,green))))
   `(helm-grep-lineno            ((t (:inherit compilation-line-number))))
   ;;`(helm-grep-match           ((t ())))
   ;;`(helm-grep-running         ((t ())))
   `(helm-header
     ((t (:foreground ,bg :background ,fg))))
   ;;`(helm-helper               ((t ())))
   ;;`(helm-history-deleted      ((t ())))
   ;;`(helm-history-remote       ((t ())))
   ;;`(helm-lisp-completion-info ((t ())))
   ;;`(helm-lisp-show-completion ((t ())))
   `(helm-locate-finish
     ((t (:foreground ,green))))
   `(helm-match-item
     ((t (:inherit lazy-highlight))))
   `(helm-match
     ((t (:foreground ,white))))
   `(helm-moccur-buffer
     ((t (:inherit compilation-info))))
   `(helm-selection
     ((t (:inherit hl-line))))
   `(helm-prefarg
     ((t (:foreground ,green :bold t))))
   ;; `(helm-selection-line
   ;;   ((t ())))
   ;;`(helm-separator
   ;;((t ())))
   `(helm-source-header
     ((t (:foreground ,black :background ,blue))))
   `(helm-visible-mark
     ((t (:foreground ,bg :background ,green))))

   ;; helm-swoop
   `(helm-swoop-line-number-face
     ((t (:inherit linum))))
   `(helm-swoop-target-word-face
     ((t (:inherit isearch))))
   `(helm-swoop-target-line-face
     ((t (:inherit highlight))))
   `(helm-swoop-target-line-block-face
     ((t (:inherit highlight :foreground ,white))))

   ;; ivy
   `(ivy-confirm-face ((t (:foreground ,green))))
   `(ivy-current-match
     ((t (:foreground ,white :background ,blue))))
   `(ivy-match-required-face ((t (:foreground ,red))))
   `(ivy-minibuffer-match-face-1
     ((t (:foreground ,white :background ,darker-gray))))
   `(ivy-minibuffer-match-face-2
     ((t (:foreground ,white :background ,dark-green :weight bold))))
   `(ivy-minibuffer-match-face-3
     ((t (:foreground ,white :background ,dark-red :weight bold))))
   `(ivy-minibuffer-match-face-4
     ((t (:foreground ,white :background ,yellow :weight bold))))
   `(ivy-modified-buffer ((t (:foreground ,orange))))
   `(ivy-remote ((t (:foreground ,light-blue))))
   `(ivy-subdir ((t (:foreground ,dark-green))))
   `(ivy-virtual ((t (:foreground ,blue))))

   ;; jabber
   `(jabber-activity-face
     ((t (:inherit font-lock-variable-name-face :bold t))))
   `(jabber-activity-personal-face
     ((t (:inherit font-lock-function-name-face :bold t))))
   `(jabber-chat-error
     ((t (:inherit error :bold t))))
   `(jabber-chat-prompt-foreign
     ((t (:foreground ,green   :underline nil :bold t))))
   `(jabber-chat-prompt-local
     ((t (:foreground ,blue    :underline nil :bold t))))
   `(jabber-chat-prompt-system
     ((t (:foreground ,yellow  :underline nil :bold t))))
   `(jabber-chat-text-foreign
     ((t (:inherit default))))
   `(jabber-chat-text-local
     ((t (:inherit default :bold t))))
   `(jabber-rare-time-face
     ((t (:foreground ,purple  :underline t))))
   `(jabber-roster-user-away
     ((t (:inherit font-lock-string-face))))
   `(jabber-roster-user-chatty
     ((t (:foreground ,orange  :bold t))))
   ;;`(jabber-roster-user-dnd
   ;;((t (:foreground "red"))))
   `(jabber-roster-user-error
     ((t (:inherit error))))
   `(jabber-roster-user-offline
     ((t (:inherit font-lock-comment-face))))
   `(jabber-roster-user-online
     ((t (:inherit font-lock-keyword-face :bold t))))
   `(jabber-roster-user-xa
     ((t (:inherit font-lock-doc-face))))
   ;;`(jabber-title-large
   ;;((t (:bold t))))
   ;;`(jabber-title-medium
   ;;((t (:bold t))))
   ;;`(jabber-title-small
   ;;((t (:bold t))))

   ;; rainbow delim
   `(rainbow-delimiters-depth-1-face
     ((t (:foreground ,purple))))
   `(rainbow-delimiters-depth-2-face
     ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-3-face
     ((t (:foreground ,orange))))
   `(rainbow-delimiters-depth-4-face
     ((t (:foreground ,light-blue))))
   `(rainbow-delimiters-depth-5-face
     ((t (:foreground ,yellow))))
   `(rainbow-delimiters-depth-6-face
     ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-7-face
     ((t (:foreground ,orange))))
   `(rainbow-delimiters-depth-8-face
     ((t (:foreground ,light-blue))))
   `(rainbow-delimiters-depth-9-face
     ((t (:foreground ,yellow))))
   `(rainbow-delimiters-unmatched-face ((t (:inherit error))))

   ;; rainbow blocks
   `(rainbow-blocks-depth-1-face
     ((t (:foreground ,purple))))
   `(rainbow-blocks-depth-2-face
     ((t (:foreground ,green))))
   `(rainbow-blocks-depth-3-face
     ((t (:foreground ,orange))))
   `(rainbow-blocks-depth-4-face
     ((t (:foreground ,light-blue))))
   `(rainbow-blocks-depth-5-face
     ((t (:foreground ,yellow))))
   `(rainbow-blocks-depth-6-face
     ((t (:foreground ,green))))
   `(rainbow-blocks-depth-7-face
     ((t (:foreground ,orange))))
   `(rainbow-blocks-depth-8-face
     ((t (:foreground ,light-blue))))
   `(rainbow-blocks-depth-9-face
     ((t (:foreground ,yellow))))
   `(rainbow-blocks-unmatched-face ((t (:inherit error))))

   ;; auto complete
   `(ac-candidate-face
     ((t (:foreground "black" :background ,fg))))
   `(ac-selection-face
     ((t (:foreground ,fg :background ,blue))))
   `(ac-candidate-mouse-face        ((t (:inherit ac-selection-face))))
   `(ac-clang-candidate-face        ((t (:inherit ac-candidate-face))))
   `(ac-clang-selection-face        ((t (:inherit ac-selection-face))))
   `(ac-completion-face
     ((t (:inherit font-lock-comment-face :underline t))))
   `(ac-gtags-candidate-face        ((t (:inherit ac-candidate-face))))
   `(ac-gtags-selection-face        ((t (:inherit ac-selection-face))))
   `(ac-slime-menu-face             ((t (:inherit ac-candidate-face))))
   `(ac-slime-selection-face        ((t (:inherit ac-selection-face))))
   `(ac-yasnippet-candidate-face    ((t (:inherit ac-candidate-face))))
   `(ac-yasnippet-selection-face    ((t (:inherit ac-selection-face))))

   ;; yasnippet
   `(yas-field-highlight-face ((t (:inherit secondary-selection))))

   ;;`(company-echo
   ;;((t (:foreground nil :background nil))))
   ;;`(company-echo-common
   ;;((t (:background "firebrick4"))))
   ;;`(company-preview
   ;;((t (:foreground "wheat" :background "blue4"))))
   `(company-preview-common
     ((t (:inherit font-lock-comment-face))))
   ;;`(company-preview-search
   ;;((t (:foreground "wheat" :background "blue1"))))
   `(company-template-field
   ((t (:inherit secondary-selection))))
   `(company-scrollbar-fg
     ((t (:background ,dark-gray))))
   `(company-scrollbar-bg
     ((t (:background ,darkest-gray))))
   `(company-tooltip
     ((t (:foreground ,bg :background ,fg))))
   `(company-tooltip-common
     ((t (:foreground ,darker-green :background ,fg))))
   `(company-tooltip-common-selection
     ((t (:foreground ,bg :background ,blue))))
   `(company-tooltip-mouse
     ((t (:background ,blue))))
   `(company-tooltip-selection
     ((t (:foreground ,fg :background ,blue))))

   ;; w3m
   ;;`(w3m-anchor
   ;;((t (:foreground "cyan"))))
   ;;`(w3m-arrived-anchor
   ;;((t (:foreground "LightSkyBlue"))))
   `(w3m-bold
     ((t (:foreground ,blue :bold t))))
   `(w3m-current-anchor
     ((t ( :underline t :bold t))))
   ;;`(w3m-form
   ;;((t (:foreground "red"  :underline t))))
   ;;`(w3m-form-button
   ;;((t (:foreground "red"  :underline t))))
   ;;`(w3m-form-button-mouse
   ;;((t (:foreground "red"  :underline t))))
   ;;`(w3m-form-button-pressed
   ;;((t (:foreground "red"  :underline t))))
   ;;`(w3m-form-inactive
   ;;((t (:foreground "grey70"  :underline t))))
   ;;`(w3m-header-line-location-content
   ;;((t (:foreground "LightGoldenrod" :background "Gray20"))))
   ;;`(w3m-header-line-location-title
   ;;((t (:foreground "Cyan" :background "Gray20"))))
   ;;`(w3m-history-current-url
   ;;((t (:foreground "LightSkyBlue" :background "SkyBlue4"))))
   ;;`(w3m-image
   ;;((t (:foreground "PaleGreen"))))
   ;;`(w3m-image-anchor
   ;;((t (:foreground nil :background "dark green"))))
   ;;`(w3m-insert
   ;;((t (:foreground "orchid"))))
   `(w3m-italic
     ((t (:foreground ,orange  :underline t))))
   ;;`(w3m-session-select
   ;;((t (:foreground "cyan"))))
   ;;`(w3m-session-selected
   ;;((t (:foreground "cyan"  :underline t :bold t))))
   ;;`(w3m-strike-through
   ;;((t (:foreground nil :background nil))))
   ;;`(w3m-tab-background
   ;;((t (:foreground "black" :background "white"))))
   ;;`(w3m-tab-mouse
   ;;((t (:foreground nil :background nil))))
   ;;`(w3m-tab-selected
   ;;((t (:foreground "black" :background "cyan"))))
   ;;`(w3m-tab-selected-background
   ;;((t (:foreground "black" :background "white"))))
   ;;`(w3m-tab-selected-retrieving
   ;;((t (:foreground "red" :background "cyan"))))
   ;;`(w3m-tab-unselected
   ;;((t (:foreground "black" :background "blue"))))
   ;;`(w3m-tab-unselected-retrieving
   ;;((t (:foreground "OrangeRed" :background "blue"))))
   ;;`(w3m-tab-unselected-unseen
   ;;((t (:foreground "gray60" :background "blue"))))
   `(w3m-underline
     ((t (:foreground ,green  :underline t))))

   ;; ediff
   `(ediff-current-diff-A         ((t (:background "#482828"))))
   `(ediff-current-diff-B         ((t (:background "#284828"))))
   `(ediff-current-diff-C         ((t (:background "#484828"))))
   ;;`(ediff-current-diff-Ancestor ((t ())))
   `(ediff-even-diff-A            ((t (:background "#191925"))))
   `(ediff-even-diff-B            ((t (:background "#191925"))))
   `(ediff-even-diff-C            ((t (:background "#191925"))))
   ;;`(ediff-even-diff-Ancestor   ((t ())))

   `(diff-added             ((t (:background "#284828"))))
   `(diff-changed           ((t (:background "#484828"))))
   `(diff-removed           ((t (:background "#482828"))))
   `(diff-context           ((t (:foreground ,gray))))
   `(diff-file-header
     ((t (:foreground ,bg :background "grey60" :bold t))))
   `(diff-function          ((t (:foreground ,bg :background "grey50"))))
   `(diff-header            ((t (:foreground ,bg :background "grey50"))))
   `(diff-hunk-header       ((t (:foreground ,bg :background "grey50"))))
   `(diff-index             ((t (:foreground ,bg :background "grey50"))))
   `(diff-indicator-added   ((t (:inherit diff-added))))
   `(diff-indicator-changed ((t (:inherit diff-changed))))
   `(diff-indicator-removed ((t (:inherit diff-removed))))
   `(diff-nonexistent       ((t (:background "grey70"))))
   `(diff-refine-added
     ((t (:foreground ,green :background ,blue-bg))))
   `(diff-refine-changed
     ((t (:foreground ,orange :background ,blue-bg))))
   `(diff-refine-removed
     ((t (:foreground ,red :background ,blue-bg))))

   `(ediff-fine-diff-A
     ((t (:foreground ,fg :background "#694949"))))
   `(ediff-fine-diff-B
     ((t (:foreground ,fg :background "#496949"))))
   `(ediff-fine-diff-C
     ((t (:foreground ,fg :background "#696949"))))
   ;;`(ediff-fine-diff-Ancestor         ((t ())))

   `(ediff-odd-diff-A           ((t (:background "#171723"))))
   `(ediff-odd-diff-B           ((t (:background "#171723"))))
   `(ediff-odd-diff-C           ((t (:background "#171723"))))
   ;;`(ediff-odd-diff-Ancestor      ((t ())))

   ;; info
   `(Info-quoted
     ((t (:inherit font-lock-constant-face))))
   `(info-menu-header
     ((t (:foreground ,light-gray :weight bold :height 1.4))))
   `(info-menu-star
     ((t (:foreground ,red))))
   `(info-node
     ((t (:foreground ,light-gray :inherit italic :weight bold))))
   `(info-title-1
     ((t (:weight bold :height 1.6))))
   `(info-title-2
     ((t (:weight bold :height 1.4))))
   `(info-title-3
     ((t (:weight bold :height 1.2))))
   `(info-title-4
     ((t (:weight bold :height 1.0))))

   ;; man pages
   `(Man-overstrike ((t (:foreground ,blue))))
   `(Man-underline  ((t (:foreground ,yellow))))

   ;; org
   ;;`(org-agenda-calendar-event     ((t (:foreground nil :background nil))))
   ;;`(org-agenda-calendar-sexp      ((t (:foreground nil :background nil))))
   ;;`(org-agenda-clocking           ((t (:foreground nil :background nil))))
   ;;`(org-agenda-column-dateline    ((t (:foreground nil :background nil))))
   ;;`(org-agenda-current-time       ((t (:foreground nil :background nil))))
   `(org-agenda-date               ((t (:foreground ,blue))))
   `(org-agenda-date-today         ((t (:foreground ,light-blue))))
   `(org-agenda-date-weekend
     ((t (:inherit org-agenda-date :slant italic))))
   ;;`(org-agenda-diary              ((t (:foreground nil :background nil))))
   ;;`(org-agenda-dimmed-todo-face   ((t (:foreground nil :background nil))))
   `(org-agenda-done               ((t (:foreground ,dark-green))))
   ;;`(org-agenda-filter-category    ((t (:foreground nil :background nil))))
   ;;`(org-agenda-filter-tags        ((t (:foreground nil :background nil))))
   ;;`(org-agenda-restriction-lock   ((t (:foreground nil :background nil))))
   `(org-agenda-structure          ((t (:foreground ,purple))))
   ;;`(org-archived                  ((t (:foreground nil :background nil))))
   ;;`(org-beamer-tag                ((t (:foreground nil :background nil))))
   ;;`(org-block                     ((t (:foreground nil :background nil))))
   ;;`(org-block-background          ((t (:foreground nil :background nil))))
   ;;`(org-block-begin-line          ((t (:foreground nil :background nil))))
   ;;`(org-block-end-line            ((t (:foreground nil :background nil))))
   ;;`(org-checkbox                  ((t (:foreground nil :background nil))))
   ;;`(org-checkbox-statistics-done  ((t (:foreground nil :background nil))))
   ;;`(org-checkbox-statistics-todo  ((t (:foreground nil :background nil))))
   ;;`(org-clock-overlay             ((t (:foreground nil :background nil))))
   ;;`(org-code                      ((t (:foreground nil :background nil))))
   ;;`(org-column                    ((t (:foreground nil :background nil))))
   ;;`(org-column-title              ((t (:foreground nil :background nil))))
   `(org-date                      ((t (:inherit link))))
   `(org-date-selected
     ((t (:inherit lazy-highlight :underline t))))
   ;;`(org-default                   ((t (:foreground nil :background nil))))
   `(org-document-info             ((t (:foreground ,lightest-green))))
   ;;`(org-document-info-keyword     ((t (:foreground nil :background nil))))
   `(org-document-title            ((t (:inherit org-document-info :bold t))))
   `(org-done
     ((t (:foreground ,dark-green))))
   `(org-todo
     ((t (:foreground ,red))))
   ;;`(org-drawer                    ((t (:foreground nil :background nil))))
   `(org-ellipsis                  ((t (:foreground ,light-gray))))
   ;;`(org-footnote                  ((t (:foreground nil :background nil))))
   ;;`(org-formula                   ((t (:foreground nil :background nil))))
   ;;`(org-headline-done             ((t (:foreground nil :background nil))))
   `(org-hide
     ((t (:foreground ,bg))))
   ;;`(org-latex-and-export-specials ((t (:foreground nil :background nil))))
   `(org-level-1
     ((t (:foreground ,purple))))
   `(org-level-2
     ((t (:foreground ,green))))
   `(org-level-3
     ((t (:foreground ,orange))))
   `(org-level-4
     ((t (:foreground ,light-blue))))
   `(org-level-5
     ((t (:foreground ,yellow))))
   `(org-level-6
     ((t (:foreground ,green))))
   `(org-level-7
     ((t (:foreground ,orange))))
   `(org-level-8
     ((t (:foreground ,light-blue))))
   ;;`(org-link                      ((t (:foreground nil :background nil))))
   ;;`(org-list-dt                   ((t (:foreground nil :background nil))))
   ;;`(org-meta-line                 ((t (:foreground nil :background nil))))
   ;;`(org-mode-line-clock           ((t (:foreground nil :background nil))))
   ;;`(org-mode-line-clock-overrun   ((t (:foreground nil :background nil))))
   ;;`(org-property-value            ((t (:foreground nil :background nil))))
   ;;`(org-quote                     ((t (:foreground nil :background nil))))
   `(org-scheduled                 ((t (:foreground ,green))))
   `(org-scheduled-previously      ((t (:foreground ,orange))))
   `(org-scheduled-today           ((t (:foreground ,yellow))))
   ;;`(org-sexp-date                 ((t (:foreground nil :background nil))))
   `(org-special-keyword           ((t (:inherit font-lock-keyword-face))))
   ;;`(org-table                     ((t (:foreground nil :background nil))))
   ;;`(org-tag                       ((t (:foreground nil :background nil))))
   ;;`(org-target                    ((t (:foreground nil :background nil))))
   ;;`(org-time-grid                 ((t (:foreground nil :background nil))))
   ;;`(org-upcoming-deadline         ((t (:foreground nil :background nil))))
   ;;`(org-verbatim                  ((t (:foreground nil :background nil))))
   ;;`(org-verse                     ((t (:foreground nil :background nil))))
   ;;`(org-warning                   ((t (:foreground nil :background nil))))

   ;; debbugs
   `(debbugs-gnu-done    ((t (:foreground ,gray))))
   `(debbugs-gnu-handled ((t (:foreground ,dark-green))))
   `(debbugs-gnu-new     ((t (:foreground ,red))))
   `(debbugs-gnu-pending ((t (:foreground ,blue))))
   `(debbugs-gnu-stale   ((t (:foreground ,orange))))
   `(debbugs-gnu-tagged  ((t (:foreground ,red))))

   ;; elfeed
   `(elfeed-log-debug-level-face     ((t (:foreground ,blue))))
   `(elfeed-log-error-level-face     ((t (:inherit error))))
   `(elfeed-log-info-level-face      ((t (:foreground ,light-green))))
   `(elfeed-log-warn-level-face      ((t (:foreground ,orange))))
   `(elfeed-search-date-face         ((t (:foreground ,blue))))
   `(elfeed-search-feed-face         ((t (:foreground ,yellow))))
   `(elfeed-search-tag-face          ((t (:foreground ,dark-green))))
   `(elfeed-search-title-face        ((t (:foreground ,fg))))
   `(elfeed-search-unread-count-face ((t (:foreground ,fg))))

   ;; paradox
   `(paradox-mode-line-face
     ((t (:foreground ,blue-bg :bold t))))

   ;; message-mode
   `(message-cited-text  ((t (:inherit font-lock-comment-face))))
   `(message-header-cc
     ((t (:foreground ,blue  :bold t))))
   `(message-header-name
     ((t (:foreground ,orange))))
   `(message-header-newsgroups
     ((t (:foreground ,dark-tan  :bold t))))
   `(message-header-other  ((t (:foreground ,blue))))
   `(message-header-subject  ((t (:foreground ,tan))))
   `(message-header-to
     ((t (:foreground ,yellow  :bold t))))
   `(message-header-xheader  ((t (:foreground ,purple))))
   `(message-mml  ((t (:foreground ,dark-tan))))

   ;; multiple-cursors
   `(mc/cursor-face ((t (:foreground ,black :background ,dark-green))))
   `(mc/cursor-bar-face ((t (:inherit mc/cursor-face :height 0.1))))

   ;; gnus
   `(gnus-button  ((t (:bold t))))
   `(gnus-cite-1  ((t (:foreground "light blue"))))
   `(gnus-cite-10 ((t (:foreground "plum1"))))
   `(gnus-cite-11 ((t (:foreground "turquoise"))))
   `(gnus-cite-2  ((t (:foreground "light cyan"))))
   `(gnus-cite-3  ((t (:foreground "light yellow"))))
   `(gnus-cite-4  ((t (:foreground "light pink"))))
   `(gnus-cite-5  ((t (:foreground "pale green"))))
   `(gnus-cite-6  ((t (:foreground "beige"))))
   `(gnus-cite-7  ((t (:foreground "orange"))))
   `(gnus-cite-8  ((t (:foreground "magenta"))))
   `(gnus-cite-9  ((t (:foreground "violet"))))
   `(gnus-cite-attribution
     ((t (:foreground nil :background nil))))
   `(gnus-emphasis-bold
     ((t (:bold t))))
   `(gnus-emphasis-bold-italic
     ((t (:bold t))))
   `(gnus-emphasis-highlight-words
     ((t (:foreground "yellow" :background "black"))))
   `(gnus-emphasis-italic
     ((t (:background nil))))
   `(gnus-emphasis-strikethru
     ((t (:background nil))))
   `(gnus-emphasis-underline
     ((t (:underline t))))
   `(gnus-emphasis-underline-bold
     ((t (:underline t :bold t))))
   `(gnus-emphasis-underline-bold-italic
     ((t (:underline t :bold t))))
   `(gnus-emphasis-underline-italic
     ((t (:underline t))))
   `(gnus-group-mail-1
     ((t (:foreground ,blue  :bold t))))
   `(gnus-group-mail-1-empty
     ((t (:foreground ,blue))))
   `(gnus-group-mail-2
     ((t (:foreground ,light-blue  :bold t))))
   `(gnus-group-mail-2-empty
     ((t (:foreground ,light-blue))))
   `(gnus-group-mail-3
     ((t (:foreground ,blue  :bold t))))
   `(gnus-group-mail-3-empty
     ((t (:foreground ,blue))))
   `(gnus-group-mail-low
     ((t (:foreground ,yellow  :bold t))))
   `(gnus-group-mail-low-empty
     ((t (:foreground ,yellow))))
   `(gnus-group-news-1
     ((t (:foreground "PaleTurquoise"  :bold t))))
   `(gnus-group-news-1-empty
     ((t (:foreground "PaleTurquoise"))))
   `(gnus-group-news-2
     ((t (:foreground "turquoise"  :bold t))))
   `(gnus-group-news-2-empty
     ((t (:foreground "turquoise"))))
   `(gnus-group-news-3
     ((t (:bold t))))
   `(gnus-group-news-3-empty
     ((t (:foreground nil :background nil))))
   `(gnus-group-news-4
     ((t (:foreground nil  :bold t))))
   `(gnus-group-news-4-empty
     ((t (:foreground nil :background nil))))
   `(gnus-group-news-5
     ((t (:bold t))))
   `(gnus-group-news-5-empty
     ((t (:foreground nil :background nil))))
   `(gnus-group-news-6
     ((t (:bold t))))
   `(gnus-group-news-6-empty
     ((t (:foreground nil :background nil))))
   `(gnus-group-news-low
     ((t (:foreground "DarkTurquoise"  :bold t))))
   `(gnus-group-news-low-empty
     ((t (:foreground "DarkTurquoise"))))
   `(gnus-header-content
     ((t (:inherit message-header-other))))
   `(gnus-header-from
     ((t (:inherit message-header-other))))
   `(gnus-header-name
     ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups
     ((t (:inherit message-header-newsgroups))))
   `(gnus-header-subject
     ((t (:inherit message-header-subject))))
   `(gnus-server-agent
     ((t (:foreground "PaleTurquoise"  :bold t))))
   `(gnus-server-closed
     ((t (:foreground "LightBlue"))))
   `(gnus-server-denied
     ((t (:foreground "pink"  :bold t))))
   `(gnus-server-offline
     ((t (:foreground "yellow"  :bold t))))
   `(gnus-server-opened
     ((t (:foreground "green1"  :bold t))))
   `(gnus-signature
     ((t (:background nil))))
   `(gnus-splash
     ((t (:foreground "#cccccc"))))
   `(gnus-summary-cancelled
     ((t (:foreground "yellow" :background "black"))))
   `(gnus-summary-high-ancient
     ((t (:foreground "SkyBlue"  :bold t))))
   `(gnus-summary-high-read
     ((t (:foreground "PaleGreen"  :bold t))))
   `(gnus-summary-high-ticked
     ((t (:foreground "pink"  :bold t))))
   `(gnus-summary-high-undownloaded
     ((t (:foreground "LightGray"  :bold t))))
   `(gnus-summary-high-unread
     ((t (:bold t))))
   `(gnus-summary-low-ancient
     ((t (:foreground "SkyBlue"))))
   `(gnus-summary-low-read
     ((t (:foreground "PaleGreen"))))
   `(gnus-summary-low-ticked
     ((t (:foreground "pink"))))
   `(gnus-summary-low-undownloaded
     ((t (:foreground "LightGray"))))
   `(gnus-summary-low-unread
     ((t (:foreground nil :background nil))))
   `(gnus-summary-normal-ancient
     ((t (:inherit default))))
   `(gnus-summary-normal-read
     ((t (:foreground ,green))))
   `(gnus-summary-normal-ticked
     ((t (:foreground ,orange))))
   `(gnus-summary-normal-undownloaded
     ((t (:foreground ,dark-gray))))
   `(gnus-summary-normal-unread
     ((t (:foreground ,blue))))
   `(gnus-summary-selected
     ((t (:underline t))))

   `(twittering-timeline-footer-face
     ((t (:inherit font-lock-function-name-face))))
   `(twittering-timeline-header-face
     ((t (:inherit font-lock-function-name-face))))
   `(twittering-uri-face
     ((t (:underline t))))
   `(twittering-username-face
     ((t (:inherit font-lock-keyword-face :underline t))))

   ;; whitespace mode
   `(whitespace-empty
     ((t (:foreground ,gray :background "gray10"))))
   `(whitespace-hspace
     ((t (:foreground ,gray :background "grey11"))))
   `(whitespace-indentation
     ((t (:foreground ,gray :background "gray12"))))
   `(whitespace-line
     ((t (:inherit error))))
   `(whitespace-newline
     ((t (:foreground ,gray))))
   `(whitespace-space
     ((t (:foreground ,gray))))
   `(whitespace-space-after-tab
     ((t (:foreground ,gray :background "gray13"))))
   `(whitespace-space-before-tab
     ((t (:foreground ,gray :background "gray14"))))
   `(whitespace-tab
     ((t (:foreground ,gray :background "grey15"))))
   `(whitespace-trailing
     ((t (:foreground ,blue :background ,bg :bold t))))

   ;; magit
   `(magit-section-heading
     ((t (:foreground ,blue))))
   `(magit-section-heading-selection
     ((t (:foreground ,light-blue))))
   `(magit-hash
     ((t (:foreground ,purple))))
   `(magit-branch-local
     ((t (:foreground ,orange))))
   `(magit-branch-remote
     ((t (:foreground ,yellow))))
   `(magit-tag
     ((t (:foreground ,light-blue))))

   `(magit-diff-file-heading
     ((t (:foreground ,fg))))
   `(magit-diff-added
     ((t (:foreground ,green))))
   `(magit-diff-removed
     ((t (:foreground ,red))))
   `(magit-diffstat-added
     ((t (:foreground ,green))))
   `(magit-diffstat-removed
     ((t (:foreground ,red))))

   `(magit-diff-hunk-heading
     ((t (:background ,dark-gray))))
   `(magit-section-highlight
     ((t (:background ,darkest-gray))))
   `(magit-diff-context-highlight
     ((t (:background ,darkest-gray))))
   `(magit-diff-file-heading-highlight
     ((t (:inherit magit-section-highlight :slant normal :underline nil))))
   `(magit-diff-hunk-heading-highlight
     ((t (:inherit magit-diff-file-heading-highlight :background ,darker-gray))))
   `(magit-diff-added-highlight
     ((t (:foreground ,green :background ,darker-gray))))
   `(magit-diff-removed-highlight
     ((t (:foreground ,red :background ,darker-gray))))
   `(magit-diff-file-heading-selection
     ((t (:foreground ,light-blue :inherit magit-diff-file-heading-highlight))))
   `(magit-diff-hunk-heading-selection
     ((t (:foreground ,light-blue :inherit magit-diff-hunk-heading-highlight))))
   `(magit-diff-lines-heading
     ((t (:background ,blue :foreground ,bg))))

   `(magit-bisect-bad
     ((t (:foreground ,red))))
   `(magit-bisect-good
     ((t (:foreground ,green))))
   `(magit-bisect-skip
     ((t (:foreground ,orange))))
   `(magit-blame-date
     ((t (:foreground ,blue :inherit magit-diff-file-heading-highlight))))
   `(magit-blame-hash
     ((t (:foreground ,purple :inherit magit-diff-file-heading-highlight))))
   `(magit-blame-heading
     ((t (:foreground ,blue :inherit magit-diff-file-heading-highlight))))
   `(magit-blame-name
     ((t (:foreground ,dark-green :inherit magit-diff-file-heading-highlight))))
   `(magit-blame-summary
     ((t (:foreground ,purple :inherit magit-diff-file-heading-highlight))))
   `(magit-blame-highlight
     ((t (:foreground ,fg :inherit magit-diff-file-heading-highlight))))

   `(magit-popup-argument
     ((t (:foreground ,red))))
   `(magit-popup-heading
     ((t (:inherit magit-section-heading))))
   `(magit-popup-key
     ((t (:inherit magit-hash))))
   `(magit-process-ng                  ((t (:foreground ,red :bold t))))
   `(magit-process-ok                  ((t (:foreground ,green))))

   `(magit-reflog-amend                ((t (:foreground ,orange))))
   `(magit-reflog-checkout             ((t (:foreground ,blue))))
   `(magit-reflog-cherry-pick          ((t (:foreground ,green))))
   `(magit-reflog-commit               ((t (:foreground ,green))))
   `(magit-reflog-merge                ((t (:foreground ,green))))
   `(magit-reflog-other                ((t (:foreground ,blue))))
   `(magit-reflog-rebase               ((t (:foreground ,orange))))
   `(magit-reflog-remote               ((t (:foreground ,blue))))
   `(magit-reflog-reset                ((t (:foreground ,red))))

   `(magit-sequence-head               ((t (:foreground ,blue))))
   `(magit-sequence-part               ((t (:foreground ,orange))))
   `(magit-sequence-stop               ((t (:foreground ,green))))

   ;;`(magit-signature-bad             ((t (:foreground "red" :bold t))))
   `(magit-signature-error             ((t (:inherit error))))
   ;;`(magit-signature-expired         ((t (:foreground "orange"))))
   ;;`(magit-signature-expired-key     ((t (:inherit magit-signature-expired))))
   `(magit-signature-good              ((t (:foreground ,green))))
   `(magit-signature-revoked           ((t (:foreground ,purple))))
   `(magit-signature-untrusted         ((t (:foreground ,blue))))

   `(magit-cherry-equivalent
     ((t (:foreground ,green))))
   `(magit-cherry-unmatched
     ((t (:foreground ,blue))))

   `(magit-log-author
     ((t (:foreground ,dark-green))))
   `(magit-log-date
     ((t (:foreground ,blue))))
   `(magit-log-graph
     ((t (:foreground ,darker-green))))

   `(git-commit-summary ((t (:inherit font-lock-constant-face))))
   `(git-commit-comment-action ((t (:foreground ,orange))))

   ;; forge
   `(forge-post-author ((t (:inherit magit-log-author :bold t))))
   `(forge-post-date ((t (:inherit magit-log-date))))
   `(forge-topic-merged ((t (:foreground ,dark-green))))
   `(forge-topic-unmerged ((t (:inherit magit-dimmed))))
   `(forge-topic-open ((t ())))
   `(forge-topic-closed ((t (:foreground ,blue-gray))))

   ;; diff-hl
   `(diff-hl-change ((t (:inherit fringe :foreground ,orange))))
   `(diff-hl-insert ((t (:inherit fringe :foreground ,green))))
   `(diff-hl-delete ((t (:inherit fringe :foreground ,red))))

   ;; git-gutter
   `(git-gutter:deleted
     ((t (:foreground ,red :bold t))))
   `(git-gutter:modified
     ((t (:foreground ,orange :bold t))))
   `(git-gutter:separator
     ((t (:foreground ,green :bold t))))
   `(git-gutter:unchanged
     ((t (:foreground ,yellow))))

   ;; guide-key
   `(guide-key/prefix-command-face    ((t (:foreground ,green))))
   `(guide-key/highlight-command-face ((t (:foreground ,blue))))
   `(guide-key/key-face               ((t (:foreground ,gray))))

   ;; indent-guide
   `(indent-guide-face ((t (:foreground ,darker-gray))))

   `(highlight-indentation-current-column-face
     ((t (:background ,gray))))
   `(highlight-indentation-face
     ((t (:background ,darker-gray))))

   ;; highlight-indent-guides
   `(highlight-indent-guides-character-face
     ((t (:foreground ,darker-gray))))
   `(highlight-indent-guides-odd-face
     ((t (:background ,darkest-gray))))
   `(highlight-indent-guides-even-face
     ((t (:background ,darker-gray))))

   ;; trailing whitespace
   `(trailing-whitespace ((t (:background ,white :bold t))))

   ;; auctex
   `(font-latex-bold-face
     ((t (:inherit bold :foreground ,dark-green))))
   `(font-latex-doctex-documentation-face
     ((t (:background unspecified))))
   `(font-latex-doctex-preprocessor-face
     ((t (:inherit (font-latex-doctex-documentation-face font-lock-preprocessor-face)))))
   `(font-latex-italic-face
     ((t (:inherit italic :foreground ,dark-green))))
   `(font-latex-math-face
     ((t (:foreground ,purple))))
   ;;`(font-latex-sectioning-0-face
   ;;((t (:inherit font-latex-sectioning-1-face :height 1.1))))
   ;;`(font-latex-sectioning-1-face
   ;;((t (:inherit font-latex-sectioning-2-face :height 1.1))))
   ;;`(font-latex-sectioning-2-face
   ;;((t (:inherit font-latex-sectioning-3-face :height 1.1))))
   ;;`(font-latex-sectioning-3-face
   ;;((t (:inherit font-latex-sectioning-4-face :height 1.1))))
   ;;`(font-latex-sectioning-4-face
   ;;((t (:inherit font-latex-sectioning-5-face :height 1.1))))
   `(font-latex-sectioning-5-face
     ((t (:foreground ,red :weight bold))))
   `(font-latex-sedate-face
     ((t (:foreground ,brown))))
   `(font-latex-slide-title-face
     ((t (:inherit font-lock-type-face :weight bold :height 1.2))))
   `(font-latex-string-face
     ((t (:inherit font-lock-string-face))))
   ;;`(font-latex-subscript-face
   ;;((t (:height 0.8))))
   ;;`(font-latex-superscript-face
   ;;((t (:height 0.8))))
   `(font-latex-verbatim-face
     ((t (:foreground ,tan))))
   `(font-latex-warning-face
     ((t (:inherit font-lock-warning-face))))
   `(TeX-error-description-error
     ((t (:inherit error :bold t))))
   `(TeX-error-description-tex-said
     ((t (:foreground ,light-blue))))
   `(TeX-error-description-warning
     ((t (:foreground ,orange :bold t))))

   ;; custom
   `(custom-button                  ((t (:foreground nil :background nil))))
   `(custom-button-mouse            ((t (:foreground nil :background nil))))
   `(custom-button-pressed          ((t (:foreground nil :background nil))))
   `(custom-button-pressed-unraised
     ((t (:foreground ,purple))))
   `(custom-button-unraised
     ((t (:foreground nil :background nil))))
   `(custom-changed
     ((t (:foreground ,red))))
   `(custom-comment
     ((t (:foreground ,bg :background ,yellow))))
   `(custom-comment-tag
     ((t (:foreground ,fg))))
   `(custom-documentation
     ((t (:foreground nil :background nil))))
   `(custom-face-tag
     ((t (:foreground ,blue))))
   `(custom-group-subtitle
     ((t (:bold t))))
   `(custom-group-tag
     ((t (:foreground ,blue  :bold t))))
   `(custom-group-tag-1
     ((t (:foreground ,yellow  :bold t))))
   `(custom-invalid
     ((t (:foreground ,bg :background ,red))))
   `(custom-link
     ((t (:inherit button))))
   `(custom-modified
     ((t (:foreground ,red))))
   `(custom-rogue
     ((t (:foreground ,yellow :background ,bg))))
   `(custom-saved
     ((t (:underline t))))
   `(custom-set
     ((t (:foreground ,fg :background ,dark-gray))))
   `(custom-state
     ((t (:foreground ,green))))
   `(custom-themed
     ((t (:foreground ,red))))
   `(custom-variable-button
     ((t (:underline t :bold t))))
   `(custom-variable-tag
     ((t (:foreground ,blue  :bold t))))
   `(custom-visibility
     ((t (:inherit button))))

   `(neo-banner-face
     ((t (:foreground ,blue :bold t))))
   `(neo-button-face
     ((t (:foreground nil :background nil))))
   `(neo-dir-link-face
     ((t (:foreground ,blue))))
   `(neo-expand-btn-face
     ((t (:foreground ,fg))))
   `(neo-file-link-face
     ((t (:foreground ,fg))))
   `(neo-header-face
     ((t (:foreground ,fg))))
   `(neo-root-dir-face
     ((t (:foreground ,green  :bold t))))
   `(neo-vc-added-face
     ((t (:foreground ,green))))
   `(neo-vc-conflict-face
     ((t (:foreground ,orange))))
   `(neo-vc-default-face
     ((t (:foreground ,fg))))
   `(neo-vc-edited-face
     ((t (:foreground ,yellow))))
   `(neo-vc-ignored-face
     ((t (:foreground ,dark-gray))))
   `(neo-vc-missing-face
     ((t (:foreground ,red))))
   `(neo-vc-needs-merge-face
     ((t (:foreground ,orange))))
   `(neo-vc-needs-update-face
     ((t (:underline t))))
   `(neo-vc-removed-face
     ((t (:foreground ,purple))))
   `(neo-vc-unlocked-changes-face
     ((t (:foreground ,red :background "Blue"))))
   `(neo-vc-unregistered-face
     ((t (:foreground nil :background nil))))
   `(neo-vc-up-to-date-face
     ((t (:foreground ,fg))))

   ;; widget
   `(widget-field  ((t (:foreground ,fg :background ,dark-gray))))

   ) ;; end of custom-theme-set-faces

  (custom-theme-set-variables
   'nimbus
   `(ansi-color-names-vector
     [,darker-gray ,red ,green ,yellow ,blue ,purple ,light-blue ,fg])))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;;;###autoload
(defun nimbus-theme()
  "Apply 'nimbus-theme'."
  (interactive)
  (load-theme 'nimbus t))


(provide-theme 'nimbus)
;;; nimbus-theme.el ends here
