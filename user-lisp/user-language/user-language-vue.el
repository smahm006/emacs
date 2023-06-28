;;; user-language-vue -- Vue development environment.

;;; Commentary:

;; Provides an integrated development environment for VueJS, with some
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)

;; VueJS language support
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
  (vue-mode . rainbow-delimiters-mode))

(provide 'user-language-vue)
;;; user-language-vue.el ends here
