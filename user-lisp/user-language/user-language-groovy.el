;;; user-language-bash -- Groovy development environment.

;;; Commentary:

;; Provides an integrated development environment for Groovy files, with some
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)

;; Groovy language support
(use-package groovy-mode
  :mode (("\\.groovy" . groovy-mode))
  :hook
  (groovy-mode . eglot-ensure)
  (groovy-mode . corfu-mode)
  (groovy-mode . display-line-numbers-mode)
  (groovy-mode . eldoc-mode)
  (groovy-mode . electric-pair-mode)
  (groovy-mode . flymake-mode)
  (groovy-mode . flyspell-prog-mode)
  (groovy-mode . hungry-delete-mode)
  (groovy-mode . rainbow-delimiters-mode))

(use-package jenkinsfile-mode
  :mode (("\\uut" . jenkinsfile-mode)))

(provide 'user-language-groovy)
;;; user-language-groovyx.el ends here
