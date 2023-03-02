;;; user-appearance -- Frame, window, buffer, and modeline appearance.

;;; Commentary:

;; Provides a modern set of appearance customisations.

;;; Code:

(require 'use-package)
(add-to-list 'custom-theme-load-path "~/.config/emacs/user-lisp/user-theme")

;; Theme
(defconst user-setting-theme-gui 'tomorrow-night-paradise)
(defconst user-setting-theme-term 'tomorrow-night-paradise)
(defconst user-setting-font "Menlo-14")

;; Hide messages when starting a new session.
(setq initial-major-mode 'markdown-mode)
(setq inhibit-startup-echo-area-message "tychoish")
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq frame-inhibit-implied-resize t)

;; Hide mouse while typing.
(setq make-pointer-invisible t)

;; Blink the cursor.
(blink-cursor-mode 1)

;; Vertical Line as cursor
(setq-default cursor-type 'bar)

;; Show column and line numbers in the mode line.
(column-number-mode)
(line-number-mode)

;; Smooth scrolling.
(use-package smooth-scrolling
  :hook (after-init . smooth-scrolling-mode))

;; Color buffer names
(use-package rainbow-mode)

;; Use a better font in graphical frames.
(when (display-graphic-p)
  (set-frame-font user-setting-font nil t))

;; Icon pack
(use-package all-the-icons
  :if (display-graphic-p))

;; Use a custom theme in GUI.
(when (display-graphic-p)
  (when (require user-setting-theme-gui nil 'noerror)
    (package-install (concat user-setting-theme-gui "-theme"))
    (require user-setting-theme-gui))
  (load-theme user-setting-theme-gui t))

;; Use a custom theme in daemon.
(when (daemonp)
  (add-to-list 'default-frame-alist (cons 'font user-setting-font))
  (add-hook 'after-make-frame-functions
            (defun my/theme-init-daemon (frame)
              (with-selected-frame frame
                (load-theme user-setting-theme-term t))
              (remove-hook 'after-make-frame-functions
                           #'my/theme-init-daemon)
              (fmakunbound 'my/theme-init-daemon)))
  (load-theme user-setting-theme-term t))

;; Disable frame decorations.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Do not use system tooltips when available.
(when (eq window-system 'x)
  (setq x-gtk-use-system-tooltips nil))

;; Show smaller gutter fringes.
(fringe-mode '(0 . 0))

;; Improve the appearance of the modeline
(use-package mood-line
  :config
  (mood-line-mode 1))

;; Implement a menu that lists enabled minor-modes
(use-package minions
  :config
  (minions-mode 1))

(use-package dashboard
  :custom
  (dashboard-projects-backend 'projectile)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 2))))

(provide 'user-appearance)
;;; user-appearance.el ends here
