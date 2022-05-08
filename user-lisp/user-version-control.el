;;; user-version-control -- Version control integration.

;;; Commentary:


;;; Code:

(require 'use-package)

;; Use an easier to type prefix for merge commands
;;(setq smerge-command-prefix "C-c m")

;; Distributed revision control interface.
(use-package magit
  :init
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  :custom
  (magit-pull-or-fetch t))

;; Git ignore files and templates
;;(use-package gitignore-mode)
;;(use-package gitignore-templates)

;;; Keyboard

(provide 'user-version-control)
;;; user-version-control.el ends here
