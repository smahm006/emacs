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

;; Window layout stack.
(winner-mode t)

;; Character and line navigation.
(use-package avy
  :custom
  (avy-all-windows nil)
  (avy-background t)
  (avy-highlight-first t)
  (avy-style 'de-bruijn))

;; Buffer navigation.
(use-package bufler
  :custom
  (bufler-columns '("Name" "VC" "Path"))
  (bufler-reverse t)
  (bufler-use-cache t)
  (bufler-vc-refresh t)
  (bufler-vc-state t))

;; Window navigation.
(use-package ace-window
  :custom
  (aw-ignore-current t)
  (aw-scope 'frame))

;; Advanced search.
(use-package swiper)

;; Preview navigation to a line.
(use-package goto-line-preview)

(defun smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

;;; Keyboard
(global-set-key (kbd "C-x f") 'toggle-maximize-buffer)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-o") #'ace-window)
(global-set-key (kbd "<C-tab>") #'next-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") #'previous-buffer)
(global-set-key (kbd "M-s a") #'avy-goto-char-timer)
(global-set-key (kbd "M-s l") #'avy-goto-line)
(global-set-key (kbd "C-x C-b") #'bufler)
(global-set-key (kbd "C-x b") #'bufler-switch-buffer)
(global-set-key (kbd "M-s g") #'goto-line-preview)
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(provide 'user-navigation)
;;; user-navigation.el ends here
