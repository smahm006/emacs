;;; user-operating-system -- Operation system integration.

;;; Commentary:

;; Provides operating system integration, filesystem navigation and
;; management, and terminal support.

;;; Code:
(require 'use-package)

;; Dired File Manager
(use-package dired
  :ensure nil
  :config
  (setf dired-kill-when-opening-new-dired-buffer t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq dired-dwim-target t)
  (setq dired-listing-switches
        "-laGh1v --group-directories-first --time-style=long-iso"))

;; Dired extras
(use-package dired-x
  :after dired
  :ensure nil)

;; Dired fonts
(use-package diredfl
  :after dired
  :hook
  (dired-mode . diredfl-mode))

;; Dired icons?
(use-package all-the-icons-dired
  :diminish all-the-icons-dired-mode
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; Filter files/directories
(use-package dired-narrow
  :after dired
  :bind
  (:map dired-mode-map
        ("C-c C-n" . dired-narrow)))

;; Using i in dired puts diredtory below
(use-package dired-subtree
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

;; Terminal
(use-package eat
  :bind
  (("C-<return>" . eat))
  :hook
  (eat-mode . hide-mode-line-mode))

;; Re-open file as sudo
(defun reopen-this-file-as-sudo ()
  (interactive)
  (let ((p (point)))
    (when-let ((file-name (filename)))
      (find-alternate-file (concat "/sudo::" file-name))
      (goto-char p))))

;;; Keyboard
(provide 'user-operating-system)
;;; user-operating-system.el ends here
