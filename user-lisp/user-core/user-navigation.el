;;; user-navigation -- Window, frame, and buffer navigation.

;;; Commentary:

;; Provides support for navigating windows, frames, and buffers without
;; using a mouse.

;;; Code:

(require 'use-package)

(use-package saveplace
  :hook (after-init . save-place-mode)
  :config
  (setq save-place-file (user-var "saveplace")))

;; Window layout stack.
(use-package winner
  :init
  (winner-mode))

;; Character and line navigation.
(use-package avy
  :bind (:map global-map
              ("C-l" . avy-goto-char-timer)
              ("M-l" . goto-line-preview))
  :custom
  (avy-all-windows t)
  (avy-background t)
  (avy-highlight-first t)
  (avy-style 'at))

;; Advanced search.
(use-package swiper
  :bind ("C-s" . swiper))

;; Uses ripgrep + nice results. This is replacing ag because ripgrep is faster
;; and the deadgrep interface is great.
(use-package deadgrep
  :bind ("M-s" . deadgrep))

;; anzu
;; Shows isearch results in mode-line and better query-replace.
(use-package anzu
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

;; Preview navigation to a line.
(use-package goto-line-preview)

(use-package recentf
  :commands recentf-mode
  :config
  (setq recentf-auto-cleanup 'never
        recentf-max-saved-items 200
        recentf-auto-cleanup 300
        recentf-exclude '("/TAGS$"
                          "/var/tmp/"
                          ".recentf"
                          "/elpa/.*\\'"))
  (setq recentf-save-file (user-var "recentf"))
  (recentf-mode))

(provide 'user-navigation)
;;; user-navigation.el ends here
