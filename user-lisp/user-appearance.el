;;; user-appearance -- Frame, window, buffer, and modeline appearance.

;;; Commentary:

;; Provides a modern set of appearance customisations.

;;; Code:

(require 'use-package)

;; Hide messages when starting a new session.
(setq initial-major-mode 'fundamental-mode)
(setq inhibit-startup-echo-area-message "tychoish")
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Blink the cursor.
(blink-cursor-mode 1)

;; Vertical Line as cursor
(setq-default cursor-type 'bar)

;; Show column and line numbers in the mode line.
(column-number-mode)
(line-number-mode)

;; Use a better font in graphical frames.
(when (display-graphic-p)
  (set-frame-font user-setting-font nil t))

;; Use a custom theme in graphical frames.
(when (display-graphic-p)
  (unless (require user-setting-theme-package nil 'noerror)
    (package-install user-setting-theme-package)
    (require user-setting-theme-package))
  (load-theme user-setting-theme t))

;; Disable frame decorations.
(menu-bar-mode user-setting-menu-bar-mode)
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

(provide 'user-appearance)
;;; user-appearance.el ends here
