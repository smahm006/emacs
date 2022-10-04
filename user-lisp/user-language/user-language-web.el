;;; user-language-web -- Web development environment.

;;; Commentary:

;; Provides an integrated web development environment for common web
;; development languages and frameworks.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)
(require 'user-hooks)

;; Additional stylesheet mode hooks
(use-package css-mode
  :mode ("\\.css\\'")
  :init
  (add-hook 'css-mode-hook #'auto-fill-mode)
  (add-hook 'css-mode-hook #'corfu-mode)
  (add-hook 'css-mode-hook #'display-line-numbers-mode)
  (add-hook 'css-mode-hook #'eldoc-mode)
  (add-hook 'css-mode-hook #'electric-pair-mode)
  (add-hook 'css-mode-hook #'emmet-mode)
  (add-hook 'css-mode-hook #'flymake-mode)
  (add-hook 'css-mode-hook #'flyspell-prog-mode)
  (add-hook 'css-mode-hook #'hl-todo-mode)
  (add-hook 'css-mode-hook #'hungry-delete-mode)
  (add-hook 'css-mode-hook #'npm-mode)
  (add-hook 'css-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'css-mode-hook #'user-auto-fill-only-comments))


;; Typescript language support
(use-package typescript-mode
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :init
  (add-hook 'typescript-mode-hook #'auto-fill-mode)
  (add-hook 'typescript-mode-hook #'corfu-mode)
  (add-hook 'typescript-mode-hook #'display-line-numbers-mode)
  (add-hook 'typescript-mode-hook #'eldoc-mode)
  (add-hook 'typescript-mode-hook #'electric-pair-mode)
  (add-hook 'typescript-mode-hook #'flymake-mode)
  (add-hook 'typescript-mode-hook #'flyspell-prog-mode)
  (add-hook 'typescript-mode-hook #'hl-todo-mode)
  (add-hook 'typescript-mode-hook #'hungry-delete-mode)
  (add-hook 'typescript-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'typescript-mode-hook #'user-auto-fill-only-comments))

;; Typescript development environment
(use-package tide
  :init
  (add-hook 'typescript-mode-hook #'tide-setup)
  (add-hook 'typescript-mode-hook #'tide-hl-identifier-mode))

;; Javascript and typescript formatting
(use-package prettier-js
  :custom
  (prettier-js-width-mode 80))

;; VueJS language support
(use-package vue-mode
  :mode "\\.vue\\'"
  :config
  (add-hook 'vue-mode-hook #'lsp-deferred)
  (add-hook 'vue-mode-hook #'auto-fill-mode)
  (add-hook 'vue-mode-hook #'corfu-mode)
  (add-hook 'vue-mode-hook #'display-line-numbers-mode)
  (add-hook 'vue-mode-hook #'eldoc-mode)
  (add-hook 'vue-mode-hook #'electric-pair-mode)
  (add-hook 'vue-mode-hook #'emmet-mode)
  (add-hook 'vue-mode-hook #'flymake-mode)
  (add-hook 'vue-mode-hook #'flyspell-prog-mode)
  (add-hook 'vue-mode-hook #'hl-todo-mode)
  (add-hook 'vue-mode-hook #'hungry-delete-mode)
  (add-hook 'vue-mode-hook #'rainbow-delimiters-mode))

;; Web and template language support
(use-package web-mode
  :mode ("\\.html?\\'" "\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'"
         "\\.as[cp]x\\'" "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'")
  :init
  (add-hook 'web-mode-hook #'auto-fill-mode)
  (add-hook 'web-mode-hook #'corfu-mode)
  (add-hook 'web-mode-hook #'display-line-numbers-mode)
  (add-hook 'web-mode-hook #'eldoc-mode)
  (add-hook 'web-mode-hook #'electric-pair-mode)
  (add-hook 'web-mode-hook #'emmet-mode)
  (add-hook 'web-mode-hook #'flymake-mode)
  (add-hook 'web-mode-hook #'flyspell-prog-mode)
  (add-hook 'web-mode-hook #'hl-todo-mode)
  (add-hook 'web-mode-hook #'hungry-delete-mode)
  (add-hook 'web-mode-hook #'npm-mode)
  (add-hook 'web-mode-hook #'rainbow-delimiters-mode)
  :custom
  (web-mode-enable-current-element-highlight t)
  (web-mode-enable-element-content-fontification t))

;; Zen coding for web development
(use-package emmet-mode
  :custom
  (emmet-move-cursor-between-quotes t))

(use-package polymode
        :hook (vue-mode . lsp-deferred)
        :mode ("\\.vue\\'" . vue-mode)
        :config
        (add-hook 'vue-mode-hook #'auto-fill-mode)
        (add-hook 'vue-mode-hook #'corfu-mode)
        (add-hook 'vue-mode-hook #'display-line-numbers-mode)
        (add-hook 'vue-mode-hook #'eldoc-mode)
        (add-hook 'vue-mode-hook #'electric-pair-mode)
        (add-hook 'vue-mode-hook #'emmet-mode)
        (add-hook 'vue-mode-hook #'flymake-mode)
        (add-hook 'vue-mode-hook #'flyspell-prog-mode)
        (add-hook 'vue-mode-hook #'hl-todo-mode)
        (add-hook 'vue-mode-hook #'hungry-delete-mode)
        (add-hook 'vue-mode-hook #'rainbow-delimiters-mode)

        (define-innermode poly-vue-template-innermode
          :mode 'html-mode
          :head-matcher "<[[:space:]]*template[[:space:]]*[[:space:]]*>"
          :tail-matcher "</[[:space:]]*template[[:space:]]*[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-script-innermode
          :mode 'typescript-mode
          :head-matcher "<[[:space:]]*script[[:space:]]*[[:space:]]*>"
          :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-script-setup-innermode
          :mode 'typescript-mode
          :head-matcher "<[[:space:]]*script[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*ts[[:space:]]*setup[[:space:]]*>"
          :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-typescript-innermode
          :mode 'typescript-mode
          :head-matcher "<[[:space:]]*script[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*ts[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-template-tag-lang-innermode
          :head-matcher "<[[:space:]]*template[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "</[[:space:]]*template[[:space:]]*[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*template[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-script-tag-lang-innermode
          :head-matcher "<[[:space:]]*script[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "</[[:space:]]*script[[:space:]]*[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*script[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-auto-innermode poly-vue-style-tag-lang-innermode
          :head-matcher "<[[:space:]]*style[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*[[:alpha:]]+[[:space:]]*[\"'][[:space:]]*>"
          :tail-matcher "</[[:space:]]*style[[:space:]]*[[:space:]]*>"
          :mode-matcher (cons  "<[[:space:]]*style[[:space:]]*lang=[[:space:]]*[\"'][[:space:]]*\\([[:alpha:]]+\\)[[:space:]]*[\"'][[:space:]]*>" 1)
          :head-mode 'host
          :tail-mode 'host)

        (define-innermode poly-vue-style-innermode
          :mode 'css-mode
          :head-matcher "<[[:space:]]*style[[:space:]]*[[:space:]]*>"
          :tail-matcher "</[[:space:]]*style[[:space:]]*[[:space:]]*>"
          :head-mode 'host
          :tail-mode 'host)

        (define-polymode vue-mode
          :hostmode 'poly-sgml-hostmode
          :innermodes '(
                        poly-vue-typescript-innermode
                        poly-vue-template-tag-lang-innermode
                        poly-vue-script-tag-lang-innermode
                        poly-vue-style-tag-lang-innermode
                        poly-vue-template-innermode
                        poly-vue-script-innermode
                        poly-vue-script-setup-innermode
                        poly-vue-style-innermode
                        )))


(provide 'user-language-web)
;;; user-language-web.el ends here
