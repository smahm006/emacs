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
  (rustic-mode . user-auto-fill-only-comments)
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

;;; Keyboard:
(with-eval-after-load 'rustic
  (define-key rustic-mode-map (kbd "C-c r t") #'rustic-cargo-test))
  (define-key rustic-mode-map (kbd "C-c r r") #'rustic-cargo-run)
  ;; (define-key rustic-mode-map (kbd "<f3>") #'rustic-compile)
  (define-key rustic-mode-map (kbd "C-c r b") #'rustic-cargo-build)
  (define-key rustic-mode-map (kbd "C-c r c") #'rustic-cargo-clippy)


(with-eval-after-load 'carrustic-mode
  (define-key cargo-minor-mode-map (kbd "<f11>") #'cargo-process-clean))

(provide 'user-language-rust)
;;; user-language-rust.el ends here
