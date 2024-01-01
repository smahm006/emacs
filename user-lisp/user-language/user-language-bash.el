(use-package bash
  :ensure nil
  :mode (("\\.sh" . bash-ts-mode))
  :init
  (setq major-mode-remap-alist '((bash-mode . bash-ts-mode)))
  :bind (:map bash-ts-mode
              ("C-c r s" . shell-check)
              ("C-c r m" . shell-region)
              ("C-c r r" . shell-compile))
  :hook
  (bash-ts-mode . eglot-ensure)
  (bash-ts-mode . corfu-mode)
  (bash-ts-mode . display-line-numbers-mode)
  (bash-ts-mode . eldoc-mode)
  (bash-ts-mode . electric-pair-mode)
  (bash-ts-mode . flymake-mode)
  (bash-ts-mode . flyspell-prog-mode)
  (bash-ts-mode . hungry-delete-mode)
  (bash-ts-mode . rainbow-delimiters-mode))

(defun shell-region (start end)
  "Execute region in an inferior shell."
  (interactive "r")
  (shell-command  (buffer-substring-no-properties start end)))

(defun shell-check ()
  "Check for bugs in bash scripts."
  (interactive)
  (compile (format "shellcheck %s" (filename))))

(defun shell-compile (args)
  "Compile current buffer file with bash."
  (interactive
   (list (read-string "Enter args: ")))
  (compile (format "bash %s %s" (filename) args)))

(provide 'user-language-bash)
;;; user-language-bash.el ends here
