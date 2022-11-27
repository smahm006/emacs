;;; user-project-management -- Project management configuration.

;;; Commentary:

;; Adds flexible project management and searching support.

;;; Code:

(require 'use-package)
(require 'user-completion)

;; Project management
(use-package projectile
  ;; :init
  ;; (shell-command "ln -sf ~/.config/emacs/local/data.known_projects ~/.config/emacs/local/data/projectile/known-projects.el")
  :bind
  ("C-c p" . projectile-command-map)
  ("C-x C-p" . projectile-switch-project)
  ("C-c p f" . projectile-find-file)
  ("C-c p a" . projectile-ag)
  ("C-c p d" . projectile-dired)
  :custom
  (shell-file-name "/bin/bash")
  (projectile-completion-system 'default)
  (projectile-indexing-method 'hybrid)
  (projectile-sort-order 'recently-active)
  :config
  (setq-default projectile-track-known-projects-automatically nil)
  (run-with-idle-timer 0.1 nil #'projectile-cleanup-known-projects)
  ;; Ensure projectile dir exists.
  (defvar my-projectile-dir (user-var "projectile"))
  (mkdir-p my-projectile-dir)
  ;; Use projectile dir for cache and bookmarks.
  (let* ((prj-dir (file-name-as-directory my-projectile-dir))
         (prj-cache-file (concat prj-dir "projectile.cache"))
         (prj-bookmarks-file (concat prj-dir "projectile-bookmarks.eld")))
    (setq projectile-cache-file          prj-cache-file
          projectile-known-projects-file prj-bookmarks-file))
  (defadvice projectile-on (around exlude-tramp activate)
    (unless  (--any? (and it (file-remote-p it))
                     (list
                      (buffer-file-name)
                      list-buffers-directory
                      default-directory
                      dired-directory))
      ad-do-it)))

(provide 'user-project-management)
;;; user-project-management.el ends here
