;;; user-development -- Common software development configuration.

;; Provides common integrated development environment functionality as
;; well as minor modes shared between multiple programming languages.

;;; Code:

(require 'use-package)

(require 'user-completion)

;; Function signature assistance
(setq eldoc-echo-area-use-multiline-p 'truncate-sym-name-if-fit)
(setq eldoc-timer 0)

;; Do not prompt to reload tag files
(setq tags-revert-without-query t)

;; Language server protocol client
(use-package eglot
  :commands (eglot eglot-ensure)
  :config
  (setq eglot-strict-mode nil)
  (setq eglot-confirm-server-initiated-edits nil)
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode) . ("clangd"))
               '(vue-mode . ("vls" "--stdio"))))


;; Syntax Checker
(use-package flymake)

;; Aggressive indentation
(use-package aggressive-indent)

;; Highlight Indetation
(use-package highlight-indent-guides
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

;; Colour nested parentheses
(use-package rainbow-delimiters)
(show-paren-mode 1)

(provide 'user-development)
;;; user-development.el ends here
