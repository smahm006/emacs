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

;; Syntax checking and linting
(use-package flycheck
  :custom
  (flycheck-buffer-switch-check-intermediate-buffers t)
  (flycheck-check-syntax-automatically '(idle-buffer-switch idle-change save))
  (flycheck-display-errors-delay 0.5)
  (flycheck-idle-buffer-switch-delay 0.1)
  (flycheck-idle-change-delay 0.1))

;; Language server protocol client
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
  :custom
  (lsp-before-save-edits t)
  (lsp-enable-file-watchers t)
  (lsp-enable-indentation t)
  (lsp-enable-on-type-formatting t)
  (lsp-enable-semantic-highlighting t)
  (lsp-enable-xref t)
  (lsp-keymap-prefix "C-c l")
  (lsp-prefer-flymake nil)
  :config
  (setq lsp-log-io nil)
  (setq lsp-enable-suggest-server-download nil)
  (setq lsp-restart 'auto-restart)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-eldoc-hook nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-semantic-tokens-enable nil)
  (setq lsp-enable-folding nil)
  (setq lsp-enable-links nil)
  (setq lsp-enable-imenu nil)
  (setq lsp-enable-snippet nil)
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.5)
  (dolist (dir '(
                 "[/\\\\]"
                 "[/\\\\]__pychache__"
                 "[/\\\\]"
                 "[/\\\\]\\.git"
                 ))
    (add-to-list 'lsp-file-watch-ignored-directories dir)))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-border (face-foreground 'default))
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-delay 0.05))


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
(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-.") 'lsp-describe-thing-at-point))

(provide 'user-development)
;;; user-development.el ends here
