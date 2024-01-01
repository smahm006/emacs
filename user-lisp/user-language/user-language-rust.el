(use-package rustic
  :bind (:map rustic-mode-map
              ("C-c r t" . rustic-cargo-test)
              ("C-c r r" . rustic-cargo-run)
              ("C-c r a" . rustic-cargo-run-with-args)
              ("C-c r k" . rustic-cargo-check)
              ("C-c r b" . rustic-cargo-build)
              ("C-c r c" . rustic-cargo-clippy)
              ("C-c r f" . rustic-popup))
  :hook
  (rustic-mode . eglot-ensure)
  (rustic-mode . corfu-mode)
  (rustic-mode . display-line-numbers-mode)
  (rustic-mode . eldoc-mode)
  (rustic-mode . electric-pair-mode)
  (rustic-mode . flymake-mode)
  (rustic-mode . flyspell-prog-mode)
  (rustic-mode . hungry-delete-mode)
  (rustic-mode . rainbow-delimiters-mode)
  (rustic-mode . rustic-mode-auto-save-hook)
  :custom
  (rustic-lsp-client 'eglot)
  (rustic-analyzer-command '("~/workstation/architecture/toolchains/rust/.cargo/bin/rust-analyzer"))
  (rustic-format-on-save t)
  (rustic-format-display-method 'ignore)
  (rustic-indent-method-chain t))

(defun rustic-mode-auto-save-hook ()
  "Enable auto-saving in rustic-mode buffers."
  (when buffer-file-name
    (setq-local compilation-ask-about-save nil)))

;; Build support
(use-package cargo
  :init
  (add-hook 'rustic-mode-hook #'cargo-minor-mode))


(provide 'user-language-rust)
;;; user-language-rust.el ends here
