;;; user-navigation -- Window, frame, and buffer navigation.

;;; Commentary:

;; Provides support for navigating windows, frames, and buffers without
;; using a mouse.

;;; Code:

(require 'use-package)

(use-package saveplace
  :hook (after-init . save-place-mode)
  :config
  (setq save-place-file (user-data "saveplace")))

;; Window layout stack.
(use-package winner
  :init
  (winner-mode))

;; Window navigation.
(use-package ace-window
  :bind ((:map global-map ("M-o" . ace-window)))
  :custom
  (aw-ignore-current t)
  (aw-scope 'frame))

;; Practical incremental narrowing commands.
(use-package consult
  :config
  (setq consult-yank-rotate 1)
  :bind (("C-s" . consult-line)
         ("C-M-s" . consult-ripgrep)
         ("M-y" . consult-yank-from-kill-ring)))

;; Character and line navigation.
(use-package avy
  :bind (:map global-map
              ("M-s" . avy-goto-char-timer))
  :custom
  (avy-all-windows t)
  (avy-background t)
  (avy-highlight-first t)
  (avy-style 'at))

;; anzu
;; Shows isearch results in mode-line and better query-replace.
(use-package anzu
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

;; Preview navigation to a line.
(use-package goto-line-preview
  :bind ("M-l" . goto-line-preview))

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
  (setq recentf-save-file (user-data "recentf"))
  (recentf-mode))

(provide 'user-navigation)
;;; user-navigation.el ends here
