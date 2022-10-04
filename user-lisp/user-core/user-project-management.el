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
  :delight projectile-mode
  :custom
  (shell-file-name "/bin/bash")
  (projectile-completion-system 'default)
  (projectile-indexing-method 'hybrid)
  (projectile-sort-order 'recently-active)
  :config
  (setq-default projectile-track-known-projects-automatically nil)
  (run-with-idle-timer 10 nil #'projectile-cleanup-known-projects)
  ;; Ensure projectile dir exists.
  (defvar my-projectile-dir (sm/cache-for "projectile"))
  (sm/mkdir-p my-projectile-dir)
  ;; Use projectile dir for cache and bookmarks.
  (let* ((prj-dir (file-name-as-directory my-projectile-dir))
         (prj-cache-file (concat prj-dir "projectile.cache"))
         (prj-bookmarks-file (concat prj-dir "projectile-bkmrks.eld")))
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

;; perspective
(use-package perspective
  :hook (after-init . persp-mode)
  :bind ("C-x b" . persp-switch-buffer)
  :custom (persp-mode-prefix-key (kbd "C-x x"))
  :config
  (defun persp-next ()
    (interactive)
    (when (< (+ 1 (persp-curr-position)) (length (persp-all-names)))
      (persp-switch (nth (1+ (persp-curr-position)) (persp-all-names))))))

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
