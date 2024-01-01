(use-package conf-mode
  :mode (("\\.editorconfig$" . conf-mode)
         ("\\.conf" . conf-mode)
         ("\\.cfg" . conf-mode)
         ("\\.ini" . conf-mode)))

;; Markdown language
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :hook
  (markdown-mode . visual-line-mode)
  (markdown-mode . flymake-mode)
  (markdown-mode . flyspell-mode)
  :custom
  (markdown-asymmetric-header t)
  (markdown-command "multimarkdown")
  (markdown-enable-math t)
  (markdown-fontify-code-blocks-natively t)
  (markdown-header-scaling nil)
  (markdown-hide-urls t)
  (markdown-italic-underscore t))

;; JavaScript object notation language (JSON)
(use-package json-mode
  :mode (("\\.json\\'" . json-ts-mode))
  :hook
  (json-ts-mode . visual-line-mode)
  (json-ts-mode . display-line-numbers-mode)
  (json-ts-mode . flymake-mode)
  (json-ts-mode . flyspell-prog-mode)
  (json-ts-mode . rainbow-delimiters-mode))

;; Yet another markup language (YAML)
(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-ts-mode)
         ("\\.yaml\\'" . yaml-ts-mode))
  :hook
  (yaml-ts-mode . visual-line-mode)
  (yaml-ts-mode . display-line-numbers-mode)
  (yaml-ts-mode . flymake-mode)
  (yaml-ts-mode . flyspell-prog-mode)
  (yaml-ts-mode . rainbow-delimiters-mode))

;; Hashicorp Configuration Language
(use-package hcl-mode
  :mode (("\\.hcl\\'" . hcl-mode)
         ("\\.tf\\'" . hcl-mode))
  :hook
  (hcl-mode . visual-line-mode)
  (hcl-mode . display-line-numbers-mode)
  (hcl-mode . flymake-mode)
  (hcl-mode . flyspell-prog-mode)
  (hcl-mode . rainbow-delimiters-mode))

;; Tom's own markup language
(use-package toml-mode
  :mode (("\\.toml\\'" . toml-mode))
  :hook
  (toml-mode . aggressive-indent-mode)
  (toml-mode . visual-line-mode)
  (toml-mode . display-line-numbers-mode)
  (toml-mode . flymake-mode)
  (toml-mode . flyspell-prog-mode)
  (toml-mode . rainbow-delimiters-mode))

;; Comma-separated value files
(use-package csv-mode
  :mode (("\\.csv\\'" . csv-mode))
  :hook
  (csv-mode . display-line-numbers-mode)
  (csv-mode . flymake-mode)
  (csv-mode . flyspell-prog-mode)
  (csv-mode . rainbow-delimiters-mode))

(provide 'user-language-config)
;;; user-language-markup ends here
