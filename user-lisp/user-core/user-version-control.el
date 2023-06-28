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
  (with-eval-after-load 'magit-mode
    (add-hook 'after-save-hook 'magit-after-save-refresh-status t))
  :commands magit-status
  :hook (git-commit-mode . flyspell-mode)
  :bind ("C-x g" . magit-status)
  :custom
  (magit-diff-refine-hunk 'all)
  (magit-pull-or-fetch t))

(provide 'user-version-control)
;;; user-version-control.el ends here
