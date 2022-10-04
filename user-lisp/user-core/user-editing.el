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
;;(setq-default backward-delete-char-untabify-method 'all)
(setq-default kill-do-not-save-duplicates t)
(setq-default kill-ring-max 1024)
(setq-default save-interprogram-paste-before-kill t)
(setq-default yank-pop-change-selection t)

;; Automatically create newlines at the end of a file.
(setq next-line-add-newlines t)

;; Backups
(setq make-backup-files nil)

;; Typing when a region is selected should replace its contents
(delete-selection-mode t)

;; When a file is saved delete trailing whitespace and ensure it ends with a newline
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

(use-package crux
  :bind (("C-x C-r" . crux-recentf-find-file)
         ("C-a" . crux-move-beginning-of-line)
         ("C-<return>" . crux-smart-open-line)
         ("C-c R" . crux-rename-buffer-and-file)
         ("C-c D" . crux-delete-buffer-and-file)
         ("s-j" . crux-top-join-line))
  :config (recentf-mode t))

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C->" . mc/mark-all-like-this))
  :custom (mc/list-file (emacs.d "etc/.mc-lists.el"))
  :custom-face
  (mc/cursor-bar-face
   ((t (:height 0.2 :background "#657b83"
                :foreground "#657b83")))))

;; Visual fill mode should respect fill-column
(use-package visual-fill-column
  :init
  (add-hook 'visual-line-mode-hook 'visual-fill-column-mode))

;; Smart region selecter
(use-package expand-region
  :bind ("M-SPC" . er/expand-region))

;; Add/Change/Delete pairs based on expand-region.
(use-package embrace
  :bind ("C-," . embrace-commander))

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
  :config
  (global-undo-tree-mode))

;; Focusing, dims surrounding text
(use-package focus)

(use-package re-builder
  :ensure nil
  :bind
  ("C-c r" . re-builder)
  :config
  (define-key reb-mode-map (kbd "RET") 'reb-replace-regexp)
  (define-key reb-lisp-mode-map (kbd "RET") 'reb-replace-regexp))

(defvar my/re-builder-positions nil
    "Store point and region bounds before calling re-builder")
  (advice-add 're-builder
              :before
              (defun my/re-builder-save-state (&rest _)
                "Save into `my/re-builder-positions' the point and region
positions before calling `re-builder'."
                          (setq my/re-builder-positions
                                (cons (point)
                                      (when (region-active-p)
                                        (list (region-beginning)
                                              (region-end)))))))
(defun reb-replace-regexp (&optional delimited)
  "Run `query-replace-regexp' with the contents of re-builder. With
non-nil optional argument DELIMITED, only replace matches
surrounded by word boundaries."
  (interactive "P")
  (reb-update-regexp)
  (let* ((re (reb-target-binding reb-regexp))
         (replacement (query-replace-read-to
                       re
                       (concat "Query replace"
                               (if current-prefix-arg
                                   (if (eq current-prefix-arg '-) " backward" " word")
                                 "")
                               " regexp"
                               (if (with-selected-window reb-target-window
                                     (region-active-p)) " in region" ""))
                       t))
         (pnt (car my/re-builder-positions))
         (beg (cadr my/re-builder-positions))
         (end (caddr my/re-builder-positions)))
    (with-selected-window reb-target-window
      (goto-char pnt) ; replace with (goto-char (match-beginning 0)) if you want
                      ; to control where in the buffer the replacement starts
                      ; with re-builder
      (setq my/re-builder-positions nil)
      (reb-quit)
      (query-replace-regexp re replacement delimited beg end))))

;;; Keyboard
(global-set-key (kbd "<C-M-backsbace>") 'just-one-space)
(global-set-key (kbd "C-c f") 'focus-mode)
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)

(provide 'user-editing)
;;; user-editing.el ends here
