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

;; Dired File Manager
(use-package dired
  :ensure nil
  :config
  (setf dired-kill-when-opening-new-dired-buffer t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t)
  (setq dired-listing-switches
        "-laGh1v --group-directories-first --time-style=long-iso"))

;; Dired extras
(use-package dired-x
  :after dired
  :ensure nil)

;; Dired fonts
(use-package diredfl
  :after dired
  :hook
  (dired-mode . diredfl-mode))

;; Dired icons?
(use-package all-the-icons-dired
  :diminish all-the-icons-dired-mode
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; Filter files/directories
(use-package dired-narrow
  :after dired
  :bind
  (:map dired-mode-map
        ("C-c C-n" . dired-narrow)))

;; Using i in dired puts diredtory below
(use-package dired-subtree
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package dired-sidebar
  :after dired
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (setq dired-sidebar-face '(:height 120))
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "-")
  (setq dired-sidebar-theme 'icons)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;;; Keyboard
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-s a") #'avy-goto-char-timer)
(global-set-key (kbd "M-s l") #'avy-goto-line)
(global-set-key (kbd "M-s g") #'goto-line-preview)
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(provide 'user-navigation)
;;; user-navigation.el ends here
