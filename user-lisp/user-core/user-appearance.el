;;; user-appearance -- Frame, window, buffer, and modeline appearance.

;;; Commentary:

;; Provides a modern set of appearance customisations.

;; Theme

;; Use a custom theme in GUI.
(use-package danneskjold-theme
  :if (display-graphic-p)
  :init
  (load-theme 'danneskjold t)
  :config
  (set-frame-font "Menlo 14" nil t))

;; Hide messages when starting a new session.
(setq initial-major-mode 'org-mode)
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

;; Icon pack
(use-package all-the-icons
  :if (display-graphic-p))

;; Disable frame decorations.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Do not use system tooltips when available.
;; (when (eq window-system 'x)
;;   (setq x-gtk-use-system-tooltips nil))

;; Show no gutter fringes.
;; (fringe-mode '(0 . 0))

;; Improve the appearance of the modeline
(use-package mood-line
  :config
  (mood-line-mode 1))

;; Disable mode line in modes of choice
(use-package hide-mode-line)

;; Implement a menu that lists enabled minor-modes
(use-package minions
  :config
  (minions-mode 1))

(provide 'user-appearance)
;;; user-appearance.el ends here
