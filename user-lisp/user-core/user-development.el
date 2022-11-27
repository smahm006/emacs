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
  (setq eglot-confirm-server-initiated-edits nil))

;; Syntax Checker
(use-package flymake
  :hook
  (flymake-mode . flymake-setup-next-error-function)
  :custom
  (help-at-pt-timer-delay 0.1)
  (help-at-pt-display-when-idle '(flymake-diagnostic))
  (flymake-proc-ignored-file-name-regexps '("\\.l?hs\\'"))
  :bind
  (:map flymake-mode-map ("M-h" . consult-flymake))
  :preface
  (defun flymake-setup-next-error-function ()
    (setq next-error-function 'flymake-next-error-compat))
  (defun flymake-next-error-compat (&optional n _)
    (flymake-goto-next-error n))
  (defun flymake-diagnostics-next-error ()
    (interactive)
    (forward-line)
    (when (eobp) (forward-line -1))
    (flymake-show-diagnostic (point)))
  (defun flymake-diagnostics-prev-error ()
    (interactive)
    (forward-line -1)
    (flymake-show-diagnostic (point)))
  :init
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake))

(use-package flymake-diagnostic-at-point
  :ensure t
  :hook
  (flymake-mode . flymake-diagnostic-at-point-mode)
  :preface
  (defun flymake-diagnostic-at-point-quick-peek (text)
    "Display the flymake diagnostic TEXT with `quick-peek'`."
    (quick-peek-show (concat flymake-diagnostic-at-point-error-prefix text)))
  :custom
  (flymake-diagnostic-at-point-error-prefix nil))

;; tree-sitter
(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

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

;; Highlight task, warning, and other comments
(use-package hl-todo)

;; Keyboard

(provide 'user-development)
;;; user-development.el ends here
