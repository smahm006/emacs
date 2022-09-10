;;; user-completion -- Buffer, minibuffer, and keyboard completion.

;;; Commentary:

;; Provides flexible buffer, minibuffer, and keyboard completion.

;;; Code:

(require 'use-package)

;; Better incremental narrowing.
(use-package selectrum
  :custom
  (selectrum-display-style '(vertical))
  :config
  (selectrum-mode))

;; Better filtering for incremental narrowing.
(use-package selectrum-prescient
  :custom
  (prescient-filter-method '(literal initialism))
  :config
  (prescient-persist-mode)
  (selectrum-prescient-mode))

;; Documentation for incremental narrowing.
(use-package marginalia
  :config
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

;; Practical incremental narrowing commands.
(use-package consult)

;; ;; Snippet support
(use-package yasnippet
  :init
  (add-hook 'lsp-mode-hook 'yas-minor-mode)
  :config
  (yas-reload-all)
  (setq yas-snippet-dirs '("~/.emacs.d/local/config/yasnippet/snippets"))
  :bind
  ("C-c y s" . yas-insert-snippet)
  ("C-c y v" . yas-visit-snippet-file))

;; Text and programming language completion.
(use-package company
  :defer t
  :custom
  (company-auto-commit nil)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-idle-delay 0.3)
  :bind
    (:map company-mode-map
	      ("<tab>". tab-indent-or-complete)
	      ("TAB". tab-indent-or-complete))
    (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))


;; Expand Yas Snippet with Tab
(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

;; Interactive keychord completion.
(use-package which-key
  :config
  (which-key-mode))

;;; Keyboard:
;; (global-set-key (kbd "C-c k k") 'which-key-show-top-level)
;; (global-set-key (kbd "C-c k ,") 'which-key-show-major-mode)
;; (global-set-key (kbd "C-c k .") 'which-key-show-minor-mode-keymap)

(provide 'user-completion)
;;; user-completion.el ends here
