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
              ("C-c r c" . rustic-cargo-clippy)
              ("C-c r f" . rustic-popup))
  :hook
  (rustic-mode . eglot-ensure)
  (rustic-mode . corfu-mode)
  (rustic-mode . display-line-numbers-mode)
  (rustic-mode . auto-fill-mode)
  (rustic-mode . eldoc-mode)
  (rustic-mode . electric-pair-mode)
  (rustic-mode . hl-todo-mode)
  (rustic-mode . flymake-mode)
  (rustic-mode . flyspell-prog-mode)
  (rustic-mode . hungry-delete-mode)
  (rustic-mode . rainbow-delimiters-mode)
  :config
  (setq rustic-lsp-client 'eglot)
  (setq rustic-analyzer-command '("~/workstation/architecture/toolchains/rust/.cargo/bin/rust-analyzer"))
  (setq rustic-format-on-save t)
  (setq rustic-indent-method-chain t))


;; Build support
(use-package cargo
  :init
  (add-hook 'rustic-mode-hook #'cargo-minor-mode))


(provide 'user-language-rust)
;;; user-language-rust.el ends here
