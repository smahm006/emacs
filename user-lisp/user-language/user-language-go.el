;;; user-language-go -- Go development environment.

;;; Commentary:

;; Provides an integrated development environment for Go, with most
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)
(require 'user-hooks)

;; Go language support
(use-package go-mode
  :init
  (add-hook 'go-mode-hook #'auto-fill-mode)
  (add-hook 'go-mode-hook #'company-mode)
  (add-hook 'go-mode-hook #'display-line-numbers-mode)
  (add-hook 'go-mode-hook #'eldoc-mode)
  (add-hook 'go-mode-hook #'electric-pair-mode)
  (add-hook 'go-mode-hook #'aggressive-indent-mode)
  (add-hook 'go-mode-hook #'hl-todo-mode)
  (add-hook 'go-mode-hook #'hungry-delete-mode)
  (add-hook 'go-mode-hook #'flycheck-mode)
  (add-hook 'go-mode-hook #'flyspell-prog-mode)
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'go-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'go-mode-hook #'user-auto-fill-only-comments)
  (add-hook 'go-mode-hook #'yas-minor-mode)
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  :custom
  (godoc-reuse-buffer t))

(defun go-build ()
  (interactive)
  (compile (format "go build %s" (filename)))
  )
;; Go test support
(use-package gotest)

;;; Keyboard:

(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "C-c r r") #'go-run)
  (define-key go-mode-map (kbd "C-c r b") #'go-build)
  (define-key go-mode-map (kbd "C-c r t") #'go-test-current-file))
  ;; (define-key go-mode-map (kbd "<f4>") #'go-test-current-test)
  ;; (define-key go-mode-map (kbd "<f5>") #'go-test-current-project))

(provide 'user-language-go)
;;; user-language-go.el ends here
