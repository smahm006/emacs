;;; user-navigation -- Window, frame, and buffer navigation.

;;; Commentary:

;; Provides support for navigating windows, frames, and buffers without
;; using a mouse.

;;; Code:

(require 'use-package)

;;(require 'user-completion)

(use-package sr-speedbar)

(use-package savehist
  :config
  '(progn
     (savehist-mode 1)
     (setq savehist-file (concat user-emacs-directory "savehist")
           savehist-save-minibuffer-history 1
           savehist-additional-variables '(kill-ring search-ring regexp-search-ring))))

(use-package saveplace
  :hook (after-init . save-place-mode)
  :config
  (setq save-place-file (user-var "saveplace")))

;; Window layout stack.
(winner-mode t)

;; Character and line navigation.
(use-package avy
  :custom
  (avy-all-windows t)
  (avy-background t)
  (avy-highlight-first t)
  (avy-style 'at))

;; Advanced search.
(use-package swiper)

;; Uses ripgrep + nice results. This is replacing ag because ripgrep is faster
;; and the deadgrep interface is great.
(use-package deadgrep
  :bind ("C-c S" . deadgrep))

;; anzu
;; Shows isearch results in mode-line and better query-replace.
(use-package anzu
  :delight anzu-mode
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
                          "/tmp/"
                          "/var/tmp/"
                          ".recentf"
                          "/elpa/.*\\'"))
  (setq recentf-save-file (sm/cache-for "recentf"))
  (recentf-mode))

(defun smart-find-file ()
  "Find files using projectile if within a project, or fall-back to `find-file'."
  (interactive)
  (if (projectile-project-p)
      (projectile-find-file)
    (call-interactively 'find-file)))

;;; Keyboard
(global-set-key (kbd "C-x C-f") #'smart-find-file)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-o") #'avy-goto-char-timer)
(global-set-key (kbd "M-g l") #'avy-goto-line)
(global-set-key (kbd "M-g g") #'goto-line-preview)

(provide 'user-navigation)
;;; user-navigation.el ends here
