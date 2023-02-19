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
  (setq vertico-cycle t)
  :config
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator))

;; Documentation for incremental narrowing.
(use-package marginalia
  :config
  (marginalia-mode))

;; Match space-seperated components
(use-package orderless
  :init
  (setq completion-styles '(orderless fast)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion)))))
  :config
  (defun orderless-fast-dispatch (word index total)
  (and (= index 0) (= total 1) (length< word 4)
       `(orderless-regexp . ,(concat "^" (regexp-quote word)))))
  (orderless-define-completion-style orderless-fast
    (orderless-style-dispatchers '(orderless-fast-dispatch))
    (orderless-matching-styles '(orderless-literal orderless-regexp))))

;; Practical incremental narrowing commands.
(use-package consult)

;; Completion Overlay Region Function, company replacement
(use-package corfu
  :init
  (global-corfu-mode)
  :bind
  (:map corfu-map
        ("SPC" . corfu-insert-separator)
        ("M-n" . nil))
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto nil)                 ;; Enable auto completion
  (corfu-auto-delay 0)
  (corfu-auto-prefix 0)
  (completion-styles '(orderless-fast))
  (corfu-popupinfo-mode t)       ;; Display docs or source in a popup
  (corfu-echo-mode t)            ;; Display docs or source in echo area
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary t)     ;; Quit at completion boundary
  (corfu-quit-no-match t)        ;; Quit if there is no match
  (corfu-preview-current t)      ;; Disable current candidate preview
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-scroll-margin 5)        ;; Use scroll margin
  :config
  (defun corfu-enable-always-in-minibuffer ()
  "Enable Corfu in the minibuffer if Vertico/Swiper are not active."
  (unless (or (bound-and-true-p mct--active)
              (bound-and-true-p vertico--input)
              (bound-and-true-p swiper--input))
    (setq-local corfu-auto nil) ;; Enable/disable auto completion
    (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
                corfu-popupinfo-delay nil)
    (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))

;; Corfu specific icons
(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  (kind-icon-default-face 'corfu-default) ; Have background color be the same as `corfu' face background
  (kind-icon-blend-background nil)  ; Use midpoint color between foreground and background colors ("blended")?
  (kind-icon-blend-frac 0.08)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Better backend language support with corfu
(use-package cape
  :bind (("M-<tab>" . completion-at-point))
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-history)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-sgml)
  (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-ispell)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  (add-to-list 'completion-at-point-functions #'cape-line))

;; Snippet support
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  ;; :custom
  ;; (tempel-trigger-prefix "<")
  :commands (tempel-expand)
  :bind (("M-n" . tempel-expand)
         ("C-M-n" . tempel-insert)
         (:map tempel-map (("M-n" . tempel-next)
                           ("M-p" . tempel-previous))))
  :config
  (setq-default tempel-path (expand-file-name "user-snippet/*.eld" "~/.config/emacs/user-lisp")))

;; Interactive keychord completion.
(use-package which-key
  :config
  (which-key-mode))


(provide 'user-completion)
;;; user-completion.el ends here
