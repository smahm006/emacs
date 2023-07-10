;;; user-language-ts -- TypeScript development environment.

;;; Commentary:

;; Provides an integrated development environment for TypeScript and Svelete, with some
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)

;; TypeScript language support
(use-package typescript-mode
  :mode (("\\.ts" . typescript-mode))
  :hook
  (typescript-mode . eglot-ensure)
  (typescript-mode . corfu-mode)
  (typescript-mode . display-line-numbers-mode)
  (typescript-mode . eldoc-mode)
  (typescript-mode . electric-pair-mode)
  (typescript-mode . flymake-mode)
  (typescript-mode . flyspell-prog-mode)
  (typescript-mode . hungry-delete-mode)
  (typescript-mode . rainbow-delimiters-mode))

;; Vue language support
(use-package vue-mode
  :mode (("\\.vue" . vue-mode))
  :hook
  (vue-mode . eglot-ensure)
  (vue-mode . corfu-mode)
  (vue-mode . display-line-numbers-mode)
  (vue-mode . eldoc-mode)
  (vue-mode . electric-pair-mode)
  (vue-mode . flymake-mode)
  (vue-mode . flyspell-prog-mode)
  (vue-mode . hungry-delete-mode)
  (vue-mode . rainbow-delimiters-mode)
  :config
  (add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil))))

(provide 'user-language-ts)
;;; user-language-ts.el ends here
