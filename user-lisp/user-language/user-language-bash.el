;;; user-language-bash -- Bash development environment.

;;; Commentary:

;; Provides an integrated development environment for Bash, with some
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)

;; Bash language support
(use-package sh-mode
  :ensure nil
  :mode (("\\.sh" . emacs-lisp-mode))
  :hook
  (sh-mode . eglot-ensure)
  (sh-mode . corfu-mode)
  (sh-mode . display-line-numbers-mode)
  (sh-mode . auto-fill-mode)
  (sh-mode . eldoc-mode)
  (sh-mode . electric-pair-mode)
  (sh-mode . hl-todo-mode)
  (sh-mode . flymake-mode)
  (sh-mode . tempel-setup-capf)
  (sh-mode . flyspell-prog-mode)
  (sh-mode . hungry-delete-mode)
  (sh-mode . tempel-setup-capf)
  (sh-mode . rainbow-delimiters-mode))

(defun shell-check ()
  (interactive)
  (compile (format "shellcheck %s" (filename))))

;;; Keyboard:
(with-eval-after-load 'sh-mode
  (define-key sh-mode-map (kbd "C-c r s") #'shell-check))

(provide 'user-language-bash)
;;; user-language-bash.el ends here
