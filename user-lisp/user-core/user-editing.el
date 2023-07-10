;;; user-editing -- Text and source code editing customisation.

;;; Commentary:

;; Provides common text editing behaviour for all major modes to be as
;; modern and unsurprising as possible.  Most of the customisations in
;; this module are default settings that can be overridden on a per-mode
;; basis.

;;; Code:

(require 'use-package)

;; Text encoding
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; Auto-fill
(setq-default comment-column 80)
(setq-default comment-empty-lines t)
(setq-default fill-column 80)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default standard-indent 4)
(setq-default tab-always-indent 'complete)
(setq-default tab-width 4)

;; Kill ring

(setq-default kill-do-not-save-duplicates t)
(setq-default kill-ring-max 1024)
(setq-default save-interprogram-paste-before-kill t)
(setq-default yank-pop-change-selection t)

;; Automatically create newlines at the end of a file.
(setq next-line-add-newlines t)

;; Typing when a region is selected should replace its contents
(delete-selection-mode t)

;; When a file is saved delete trailing whitespace and ensure it ends with a newline
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

(use-package crux
  :bind (("C-x C-r" . crux-recentf-find-file)
         ("C-a" . crux-move-beginning-of-line)
         ("C-<return>" . crux-smart-open-line)
         ("M-<return>" . crux-smart-open-line-above)
         ("s-j" . crux-top-join-line)))

;; Visual fill mode should respect fill-column
(use-package visual-fill-column
  :hook
  (visual-line-mode-hook . visual-fill-column-mode))

;; Better `comment-dwim' supporting uncommenting.
(use-package smart-comment
  :bind ("M-;" . smart-comment))

;; Browse-kill-ring
(use-package browse-kill-ring
  :bind ("M-y" . browse-kill-ring))

;; Hungry deletion minor mode
(use-package hungry-delete
  :config
  (setq hungry-delete-join-reluctantly t))

;; Simple undo and redo system
(use-package undo-fu
  :bind (:map global-map
              ("C-/" . undo-fu-only-undo)
              ("M-_" . undo-fu-only-redo))
  :config
  (setq undo-limit 67108864) ; 64mb.
  (setq undo-strong-limit 100663296) ; 96mb.
  (setq undo-outer-limit 1006632960)) ; 960mb

;; Save undo history between sessions
(use-package undo-fu-session
  :init
  (undo-fu-session-global-mode 1)
  :custom
  (undo-fu-session-directory (user-data "undo-fu-session")))

;; Undo-tree visualization
(use-package vundo
  :bind ("C-M-/" . vundo)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols))


;; Focusing, dims surrounding text
(use-package focus
  :bind ("C-c f" . focus-mode))

(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

;;; Keyboard
(global-set-key (kbd "C-M-p") 'move-text-up)
(global-set-key (kbd "C-M-n") 'move-text-down)
(global-set-key (kbd "C-c w c") 'capitalize-dwim)
(global-set-key (kbd "C-c w d") 'downcase-dwim)
(global-set-key (kbd "C-c w u") 'upcase-dwim)

(provide 'user-editing)
;;; user-editing.el ends here
