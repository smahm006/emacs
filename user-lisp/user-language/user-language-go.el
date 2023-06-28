;;; user-language-go -- Go development environment.

;;; Commentary:

;; Provides an integrated development environment for Go, with most
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)

;; Go language support
(use-package go-mode
  :hook
  (go-mode . eglot-ensure)
  (go-mode . corfu-mode)
  (go-mode . display-line-numbers-mode)
  (go-mode . eldoc-mode)
  (go-mode . electric-pair-mode)
  (go-mode . flymake-mode)
  (go-mode . flyspell-prog-mode)
  (go-mode . hungry-delete-mode)
  (go-mode . rainbow-delimiters-mode)
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  :custom
  (godoc-reuse-buffer t))

(defun go-build ()
  "Compile current buffer file with go."
  (interactive)
  (compile (format "go build %s" (filename))))

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
