;;; user-completion -- Buffer, minibuffer, and keyboard completion.

;;; Commentary:

;; Provides flexible buffer, minibuffer, and keyboard completion.

;;; Code:

(require 'use-package)

;; Better incremental narrowing.
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-scroll-margin 0)
  (setq vertico-count 15)
  (setq vertico-resize t)
  (setq vertico-cycle t))

;; Documentation for incremental narrowing.
(use-package marginalia
  :init
  (marginalia-mode))

(use-package embark
  :bind
  (("C-." . embark-act)))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Match text in any order
(use-package orderless
  :init
  (setq completion-styles '(orderless flex)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (basic partial-completion))))))

;; Completion Overlay Region Function, company replacement
(use-package corfu
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1)
  (corfu-popupinfo-mode t)       ;; Display docs or source in a popup
  (corfu-quit-no-match t)        ;; Quit if there is no match
  (corfu-preview-current t)      ;; Show current candidate preview
  (corfu-on-exact-match nil))     ;; Configure handling of exact matches

;; Corfu specific icons
(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  (kind-icon-blend-background nil)  ; Have background color be the same as `corfu' face background
  (kind-icon-blend-frac 0.08) ; Use midpoint color between foreground and background colors ("blended")?
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Snippet support
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  ;; :custom
  ;; (tempel-trigger-prefix "<")
  :commands (tempel-expand)
  :bind (("M-+" . tempel-expand)
         ("M-*" . tempel-insert)
         (:map tempel-map (("C-n" . tempel-next)
                           ("C-p" . tempel-previous))))
  :config
  (setq-default tempel-path (expand-file-name "user-snippet/*.eld" "~/.config/emacs/user-lisp")))

;; Interactive keychord completion.
(use-package which-key
  :config
  (which-key-mode))


(provide 'user-completion)
;;; user-completion.el ends here
