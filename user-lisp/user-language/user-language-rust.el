;;; user-language-rust -- Rust development environment.

;;; Commentary:

;; Provides an integrated development environment for Rust, with most
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)

;; Rust language support
(use-package rustic
  :bind (:map rustic-mode-map
              ("C-c r t" . rustic-cargo-test)
              ("C-c r r" . rustic-cargo-run)
              ("C-c r b" . rustic-cargo-build)
              ("C-c r c" . rustic-cargo-clippy))
  :hook
  (rustic-mode . eglot-ensure)
  (rustic-mode . corfu-mode)
  (rustic-mode . display-line-numbers-mode)
  (rustic-mode . auto-fill-mode)
  (rustic-mode . eldoc-mode)
  (rustic-mode . electric-pair-mode)
  (rustic-mode . hl-todo-mode)
  (rustic-mode . flymake-mode)
  (rustic-mode . tempel-setup-capf)
  (rustic-mode . flyspell-prog-mode)
  (rustic-mode . hungry-delete-mode)
  (rustic-mode . tempel-setup-capf)
  (rustic-mode . rainbow-delimiters-mode)
  :config
  (setq rustic-analyzer-command '("~/.cargo/bin/rust-analyzer"))
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (push 'rustic-clippy flycheck-checkers)
  (setq rust-format-on-save t)
  (setq rustic-format-on-save t)
  (setq rustic-indent-method-chain t))


;; Build support
(use-package cargo
  :init
  (add-hook 'rustic-mode-hook #'cargo-minor-mode))


(provide 'user-language-rust)
;;; user-language-rust.el ends here
