;;; user-language-bash -- Bash development environment.

;;; Commentary:

;; Provides an integrated development environment for Bash, with some
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)

;; Bash language support
(use-package sh-script
  :ensure nil
  :mode (("\\.sh" . sh-script))
  :bind (:map sh-mode-map
              ("C-c r s" . shell-check)
              ("C-c r m" . shell-region)
              ("C-c r r" . shell-compile))
  :hook
  (sh-script . eglot-ensure)
  (sh-script . corfu-mode)
  (sh-script . display-line-numbers-mode)
  (sh-script . eldoc-mode)
  (sh-script . electric-pair-mode)
  (sh-script . flymake-mode)
  (sh-script . flyspell-prog-mode)
  (sh-script . hungry-delete-mode)
  (sh-script . rainbow-delimiters-mode))

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
