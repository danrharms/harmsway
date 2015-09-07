;;; color-theme-empty-void.el
(defun color-theme-empty-void ()
  "The Empty Void color theme, by mtvoid (based on sunburst)"
  (interactive)
  (color-theme-install
   '(color-theme-empty-void
     ((background-color . "black")
      (background-mode . dark)
      (border-color . "gray20")
      (cursor-color . "yellow")
      (foreground-color . "white smoke")
      (mouse-color . "sienna1"))
     (default ((t nil)))
     (bold ((t (:bold t))))
     (bold-italic ((t (:bold t :slant italic))))
     (diary ((t (:foreground "tomato"))))
     (font-lock-builtin-face ((t (:foreground "#dd7b3b"))))
     (font-lock-comment-face ((t (:foreground "#999" :italic t))))
     (font-lock-comment-delimiter-face ((t (:foreground "#e44" :italic t))))
     (font-lock-constant-face ((t (:foreground "#99cf50"))))
     (font-lock-doc-face ((t (:foreground "#9b859d"))))
     (font-lock-function-name-face ((t (:foreground "#e9c062" :bold t))))
     (font-lock-keyword-face ((t (:foreground "#cf6a4c" :bold t))))
     (font-lock-preprocessor-face ((t (:foreground "#aeaeae"))))
     (font-lock-string-face ((t (:foreground "#65b042"))))
     (font-lock-type-face ((t (:foreground "#c5af75"))))
     (font-lock-variable-name-face ((t (:foreground "#3387cc"))))
     (font-lock-warning-face ((t (:bold t :background "#420e09" :foreground "#eeeeee"))))
     (fringe ((t (:background "gray4"))))
     (erc-current-nick-face ((t (:foreground "#aeaeae"))))
     (erc-default-face ((t (:foreground "#ddd"))))
     (erc-keyword-face ((t (:foreground "#cf6a4c"))))
     (erc-notice-face ((t (:foreground "#666"))))
     (erc-timestamp-face ((t (:foreground "#65b042"))))
     (erc-underline-face ((t (:foreground "c5af75"))))
     (highlight-current-line-face ((t (:background "gray10"))))
     (minibuffer-prompt ((t (:foreground "orange red"))))
     (nxml-attribute-local-name-face ((t (:foreground "#3387cc"))))
     (nxml-attribute-colon-face ((t (:foreground "#e28964"))))
     (nxml-attribute-prefix-face ((t (:foreground "#cf6a4c"))))
     (nxml-attribute-value-face ((t (:foreground "#65b042"))))
     (nxml-attribute-value-delimiter-face ((t (:foreground "#99cf50"))))
     (nxml-namespace-attribute-prefix-face ((t (:foreground "#9b859d"))))
     (nxml-comment-content-face ((t (:foreground "#666"))))
     (nxml-comment-delimiter-face ((t (:foreground "#333"))))
     (nxml-element-local-name-face ((t (:foreground "#e9c062"))))
     (nxml-markup-declaration-delimiter-face ((t (:foreground "#aeaeae"))))
     (nxml-namespace-attribute-xmlns-face ((t (:foreground "#8b98ab"))))
     (nxml-prolog-keyword-face ((t (:foreground "#c5af75"))))
     (nxml-prolog-literal-content-face ((t (:foreground "#dad085"))))
     (nxml-tag-delimiter-face ((t (:foreground "#cda869"))))
     (nxml-tag-slash-face ((t (:foreground "#cda869"))))
     (nxml-text-face ((t (:foreground "#ddd"))))
     (gui-element ((t (:background "#0e2231" :foreground "black"))))
     (highlight ((t (:background "gray10"))))
     (highline-face ((t (:background "#4a410d"))))
     (italic ((t (:slant italic))))
     (left-margin ((t (nil))))
     (mmm-default-submode-face ((t (:background "#111"))))
     (mode-line ((t (:background "gray5" :foreground "gray" :box '(:width 1 :style nil)))))
     (mode-line-buffer-id ((t (:background "gray5" :foreground "gray"))))
     (mode-line-highlight ((t (:box '(:width 1 :style nil)))))
     (mode-line-inactive ((t (:background "gray5" :foreground "gray40"))))
     (primary-selection ((t (:background "#222"))))
     (region ((t (:background "midnight blue"))))
     (text-cursor ((t (:background "yellow" :foreground "black"))))
     (tool-bar ((t (:background "gray75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:background "gray5" :foreground "white"))))
     (underline ((nil (:underline t)))))))
