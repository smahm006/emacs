;;; user-version-control -- Version control integration.

;;; Commentary:


;;; Code:

(require 'use-package)

;; Use an easier to type prefix for merge commands
;;(setq smerge-command-prefix "C-c m")

;; Git ignore files and templates
(use-package git-modes)

;; Distributed revision control interface.
(use-package magit
  :init
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  :commands magit-status
  :hook (git-commit-mode . flyspell-mode)
  :bind ("C-x g" . magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (magit-diff-refine-hunk 'all)
  (magit-pull-or-fetch t))

;; Git forge w/ magit.
(use-package forge
  :after magit)

(provide 'user-version-control)
;;; user-version-control.el ends here
