;;; user-language-bash -- Bash development environment.

;;; Commentary:

;; Provides an integrated development environment for Bash, with some
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)
(require 'user-hooks)

;; Bash language support
(use-package sh-mode
  :ensure nil
  :init
  (add-hook 'sh-mode-hook #'auto-fill-mode)
  (add-hook 'sh-mode-hook #'company-mode)
  (add-hook 'sh-mode-hook #'display-line-numbers-mode)
  (add-hook 'sh-mode-hook #'eldoc-mode)
  (add-hook 'sh-mode-hook #'electric-pair-mode)
  (add-hook 'sh-mode-hook #'aggressive-indent-mode)
  (add-hook 'sh-mode-hook #'hl-todo-mode)
  (add-hook 'sh-mode-hook #'hungry-delete-mode)
  (add-hook 'sh-mode-hook #'flycheck-mode)
  (add-hook 'sh-mode-hook #'flyspell-prog-mode)
  (add-hook 'sh-mode-hook #'lsp-deferred)
  (add-hook 'sh-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'sh-mode-hook #'user-auto-fill-only-comments)
  (add-hook 'sh-mode-hook #'yas-minor-mode)

(defun shell-check ()
  (interactive)
  (compile (format "shellcheck %s" (filename)))
  )

;;; Keyboard:
(with-eval-after-load 'sh-mode
  (define-key sh-mode-map (kbd "C-c r s") #'shell-check)

(provide 'user-language-bash)
;;; user-language-bash.el ends here
