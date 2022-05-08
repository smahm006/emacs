;;; user-language-rust -- Rust development environment.

;;; Commentary:

;; Provides an integrated development environment for Rust, with most
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)
(require 'user-hooks)

;; Rust language support
(use-package rustic
  :init
  (add-hook 'rustic-mode-hook #'auto-fill-mode)
  (add-hook 'rustic-mode-hook #'company-mode)
  (add-hook 'rustic-mode-hook #'display-line-numbers-mode)
  (add-hook 'rustic-mode-hook #'eldoc-mode)
  (add-hook 'rustic-mode-hook #'aggressive-indent-mode)
  (add-hook 'rustic-mode-hook #'electric-pair-mode)
  (add-hook 'rustic-mode-hook #'hl-todo-mode)
  (add-hook 'rustic-mode-hook #'hungry-delete-mode)
  (add-hook 'rustic-mode-hook #'flycheck-mode)
  (add-hook 'rustic-mode-hook #'flyspell-prog-mode)
  (add-hook 'rustic-mode-hook #'lsp-deferred)
  (add-hook 'rustic-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'rustic-mode-hook #'user-auto-fill-only-comments)
  (add-hook 'rustic-mode-hook #'yas-minor-mode)
  :config
  (setq lsp-rust-server 'rust-analyzer)
  (setq rustic-analyzer-command '("~/.cargo/bin/rust-analyzer"))
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (push 'rustic-clippy flycheck-checkers)
  (setq lsp-eldoc-render-all t)
  (setq lsp-idle-delay 0.5)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq rust-format-on-save t)
  (setq rustic-format-on-save t)
  (setq rustic-indent-method-chain t))

;; Build support
(use-package cargo
  :init
  (add-hook 'rustic-mode-hook #'cargo-minor-mode))

;;; Keyboard:
(with-eval-after-load 'rustic
  (define-key rustic-mode-map (kbd "C-c r t") #'rustic-cargo-test))
  (define-key rustic-mode-map (kbd "C-c r r") #'rustic-cargo-run)
  ;; (define-key rustic-mode-map (kbd "<f3>") #'rustic-compile)
  (define-key rustic-mode-map (kbd "C-c r b") #'rustic-cargo-build)
  (define-key rustic-mode-map (kbd "C-c r c") #'rustic-cargo-clippy)


(with-eval-after-load 'cargo-mode
  (define-key cargo-minor-mode-map (kbd "<f11>") #'cargo-process-clean))

(provide 'user-language-rust)
;;; user-language-rust.el ends here
