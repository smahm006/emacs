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
(setq-default comment-column 120)
(setq-default comment-empty-lines t)
(setq-default fill-column 120)

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
         ("C-o" . crux-smart-open-line)
         ("C-M-o" . crux-smart-open-line-above)
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
(use-package undo-tree
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.config/emacs/local/data/undo-tree")))
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
  (defun my-undo-tree-suppress-buffer-modified-message
      (undo-tree-load-history &rest args)
    (let ((message-log-max nil)
          (inhibit-message t))
      (apply undo-tree-load-history args)))
  (defun my-undo-tree-suppress-undo-history-saved-message
      (undo-tree-save-history &rest args)
    (let ((message-log-max nil)
          (inhibit-message t))
      (apply undo-tree-save-history args)))
  (advice-add 'undo-tree-load-history :around 'my-undo-tree-suppress-buffer-modified-message)
  (advice-add 'undo-tree-save-history :around 'my-undo-tree-suppress-undo-history-saved-message))

;; Focusing, dims surrounding text
(use-package focus
  :bind ("C-c f" . focus-mode))

;;; Keyboard
(global-set-key (kbd "C-c w c") 'capitalize-dwim)
(global-set-key (kbd "C-c w d") 'downcase-dwim)
(global-set-key (kbd "C-c w u") 'upcase-dwim)

(provide 'user-editing)
;;; user-editing.el ends here
