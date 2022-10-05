;;; user-language-emacs-lisp -- Emacs lisp development environment.

;;; Commentary:

;; Configures and provides minor modes that make writing Emacs Lisp more
;; pleasant.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)

;; Hooks
(use-package lisp-mode
  :ensure nil
  :mode (("\\.el" . emacs-lisp-mode))
  :hook
  (emacs-lisp-mode . corfu-mode)
  (emacs-lisp-mode . display-line-numbers-mode)
  (emacs-lisp-mode . auto-fill-mode)
  (emacs-lisp-mode . eldoc-mode)
  (emacs-lisp-mode . electric-pair-mode)
  (emacs-lisp-mode . hl-todo-mode)
  (emacs-lisp-mode . flymake-mode)
  (emacs-lisp-mode . tempel-setup-capf)
  (emacs-lisp-mode . flyspell-prog-mode)
  (emacs-lisp-mode . hungry-delete-mode)
  (emacs-lisp-mode . tempel-setup-capf)
  (emacs-lisp-mode . rainbow-delimiters-mode))

;; Code evaluation
(use-package eros
  :init
  (add-hook 'emacs-lisp-mode-hook 'eros-mode))


(provide 'user-language-emacs-lisp)
;;; user-language-emacs-lisp.el ends here
