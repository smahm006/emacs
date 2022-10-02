;;; user-project-management -- Project management configuration.

;;; Commentary:

;; Adds flexible project management and searching support.

;;; Code:

(require 'use-package)
(require 'user-completion)

;; Project management
(use-package projectile
  :init
  (shell-command "ln -sf ~/.config/emacs/.known_projects ~/.config/emacs/local/data/projectile/known-projects.el")
  :custom
  (projectile-completion-system 'default)
  (projectile-indexing-method 'hybrid)
  (projectile-sort-order 'recently-active)
  :config
  (projectile-mode)
  (setq-default projectile-track-known-projects-automatically nil)
  (run-with-idle-timer 10 nil #'projectile-cleanup-known-projects)
  (setq projectile-mode-line "Projectile")
  (defadvice projectile-on (around exlude-tramp activate)
    (unless  (--any? (and it (file-remote-p it))
                     (list
                      (buffer-file-name)
                      list-buffers-directory
                      default-directory
                      dired-directory))
      ad-do-it)))

;; Search
(use-package ag
  :custom
  (ag-highlight-search t))

;; Search result formatting
(use-package winnow
  :hook (ag-mode . winnow-mode))

;;; Keyboard
(with-eval-after-load 'projectile
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (global-set-key (kbd "C-x C-p") #'projectile-switch-project)
  (global-set-key (kbd "C-c p f") #'projectile-find-file)
  (global-set-key (kbd "C-c p a") #'projectile-ag)
  (global-set-key (kbd "<f4>") #'projectile-find-tag)
  (global-set-key (kbd "C-c p d") #'projectile-dired))

(provide 'user-project-management)
;;; user-project-management.el ends here
