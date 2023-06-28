;;; user-appearance -- Frame, window, buffer, and modeline appearance.

;;; Commentary:

;; Provides a modern set of appearance customisations.

;; Theme
(add-to-list 'custom-theme-load-path "~/.config/emacs/user-lisp/user-theme")
(defconst user-setting-theme-gui-package 'danneskjold-theme)
(defconst user-setting-theme-gui-name 'danneskjold)
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
  (condition-case nil 
    (load-theme user-setting-theme-gui-name t)
    (error (condition-case nil 
      (progn
      (package-install user-setting-theme-gui-package)
      (require user-setting-theme-gui-package)
      (load-theme user-setting-theme-gui-name t))
      (error (load-theme user-setting-theme-term t))))))

;; Disable frame decorations.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Do not use system tooltips when available.
;; (when (eq window-system 'x)
;;   (setq x-gtk-use-system-tooltips nil))

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
