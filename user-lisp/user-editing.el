;;; user-editing -- Text and source code editing customisation.

;;; Commentary:

;; Provides common text editing behaviour for all major modes to be as
;; modern and unsurprising as possible.  Most of the customisations in
;; this module are default settings that can be overridden on a per-mode
;; basis.

;;; Code:

(require 'use-package)

;; Text encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

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

;; Saving
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; Refresh buffers
(setq auto-revert-interval 1)
(global-auto-revert-mode)

;; Typing when a region is selected should replace its contents
(delete-selection-mode)

;; When a file is saved delete trailing whitespace and ensure it ends with a newline
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

;; Visual fill mode should respect fill-column
(use-package visual-fill-column
  :init
  (add-hook 'visual-line-mode-hook 'visual-fill-column-mode))

;; Smart region selecter
(use-package expand-region
  :bind ("M-SPC" . er/expand-region))

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
  :ensure nil)

;; query replace all from buffer start
(fset 'query-replace-wraparound 'query-replace)
(advice-add 'query-replace-wraparound
            :around
            #'(lambda(oldfun &rest args)
               "Query replace the whole buffer."
               ;; set start pos
               (unless (nth 3 args)
                 (setf (nth 3 args)
                       (if (use-region-p)
                           (region-beginning)
                         (point-min))))
               (unless (nth 4 args)
                 (setf (nth 4 args)
                       (if (use-region-p)
                           (region-end)
                         (point-max))))
               (apply oldfun args)))

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
(global-set-key (kbd "M-%") 'query-replace-wraparound)
(global-set-key (kbd "C-c r") 're-builder)
(define-key reb-mode-map (kbd "RET") 'reb-replace-regexp)
(define-key reb-lisp-mode-map (kbd "RET") 'reb-replace-regexp)
(global-set-key (kbd "<C-M-backsbace>") 'just-one-space)
(global-set-key (kbd "C-c f") 'focus-mode)
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-u") 'upcase-dwim)

(provide 'user-editing)
;;; user-editing.el ends here
