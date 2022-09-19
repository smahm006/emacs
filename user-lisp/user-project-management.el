;;; user-project-management -- Project management configuration.

;;; Commentary:

;; Adds flexible project management and searching support.

;;; Code:

(require 'use-package)
(require 'user-completion)

;; Project management
(use-package projectile
  :init
  (shell-command "ln -sf ~/.emacs.d/.known_projects ~/.emacs.d/local/data/projectile/known-projects.el")
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

;; Breakdown of code in treelike manner
(use-package treemacs
  :init
  (defun open-tree ()
  (interactive)
  (progn
    (when (derived-mode-p 'prog-mode)
      (lsp-treemacs-symbols-toggle))
    (pcase (treemacs-current-visibility)
      ('visible (delete-window (treemacs-get-local-window)))
      ('exists  (treemacs-display-current-project-exclusively))
      ('none    (treemacs-display-current-project-exclusively)))
    (other-window -1)))
  :config
  (setq treemacs-width 25
        treemacs-follow-mode -1
        treemacs-tag-follow-mode -1
        treemacs-is-never-other-window t
        treemacs-follow-after-init t
        treemacs-no-png-images t
        treemacs-icon-open-png   (propertize "⊖ " 'face 'treemacs-directory-face)
        treemacs-icon-closed-png (propertize "⊕ " 'face 'treemacs-directory-face)
        treemacs-sorting 'alphabetic-case-insensitive-asc
        treemacs-text-scale -1.3)
  (dolist (face '(treemacs-git-unmodified-face
                  treemacs-git-modified-face
                  treemacs-git-renamed-face
                  treemacs-git-ignored-face
                  treemacs-git-untracked-face
                  treemacs-git-added-face
                  treemacs-git-conflict-face
                  treemacs-file-face
                  treemacs-tags-face))
    (set-face-attribute face nil :family "Noto Sans" :height 110))
  (dolist (face '(treemacs-root-face
                  treemacs-directory-face
                  treemacs-directory-collapsed-face))
    (set-face-attribute face nil :family "Noto Sans" :height 130)))

(use-package lsp-treemacs
    :init
    (defun lsp-treemacs-symbols-toggle ()
      "Toggle the lsp-treemacs-symbols buffer."
      (interactive)
      (if (get-buffer "*LSP Symbols List*")
          (kill-buffer "*LSP Symbols List*")
        (progn
          (lsp-treemacs-symbols)
          (lsp-treemacs-symbols)
          (other-window -1))))
    :config
    (lsp-treemacs-sync-mode 1)
    (defun lsp-treemacs--generic-icon (&rest _) ""))

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

(with-eval-after-load 'treemacs
  (global-set-key (kbd "C-c t t") #'treemacs-select-window)
  (global-set-key (kbd "C-c t f") #'lsp-treemacs-symbols))

(provide 'user-project-management)
;;; user-project-management.el ends here
