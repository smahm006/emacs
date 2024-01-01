;;; user-development -- Common software development configuration.

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
               `((c++-mode c-mode) . ("clangd"))
               `(rustic-mode . ("rust-analyzer" :initializationOptions
                              (:procMacro (:enable t)
                                          :cargo (:buildScripts (:enable t)
                                                                :features
                                                                "all"))))))

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
