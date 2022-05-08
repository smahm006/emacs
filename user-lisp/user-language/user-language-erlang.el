;;; user-language-erlang -- Erlang and OTP development environment.

;;; Commentary:

;; Provides an integrated development environment for Erlang and OTP
;; languages.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)
(require 'user-hooks)

;; Elixir language support
(use-package elixir-mode
  :init
  (add-hook 'elixir-mode-hook #'auto-fill-mode)
  (add-hook 'elixir-mode-hook #'company-mode)
  (add-hook 'elixir-mode-hook #'display-line-numbers-mode)
  (add-hook 'elixir-mode-hook #'eldoc-mode)
  (add-hook 'elixir-mode-hook #'electric-pair-mode)
  (add-hook 'elixir-mode-hook #'hl-todo-mode)
  (add-hook 'elixir-mode-hook #'hungry-delete-mode)
  (add-hook 'elixir-mode-hook #'flycheck-mode)
  (add-hook 'elixir-mode-hook #'flyspell-prog-mode)
  (add-hook 'elixir-mode-hook #'lsp)
  (add-hook 'elixir-mode-hook #'mix-minor-mode)
  (add-hook 'elixir-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'elixir-mode-hook #'user-auto-fill-only-comments)
  (add-hook 'elixir-mode-hook #'yas-minor-mode)
  :config
  (when user-setting-elixir-language-server
    (add-to-list 'exec-path user-setting-elixir-language-server)))

;; Elixir build system support
(use-package mix)

;;; Keyboard:

(with-eval-after-load 'mix-mode
  (define-key mix-minor-mode-map (kbd "<f9>") #'mix-execute-task)
  (define-key mix-minor-mode-map (kbd "<f10>") #'mix-test))

(provide 'user-language-erlang)
;;; user-language-erlang.el ends here
