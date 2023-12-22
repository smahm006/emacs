;;; user-system -- Operation system integration.

;;; Commentary:

;; Provides operating system integration, filesystem navigation and
;; management, and terminal support.

;;; Code:
(require 'use-package)

(defun empty-trash ()
  "Empty the trash"
  (interactive)
  (shell-command "trash-empty"))

;; File Manager
(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :bind
  (("<f1>" . dirvish-side)
   :map dirvish-mode-map
   ("M-p" . dired-up-directory)
   ("M-n" . dired-find-file)
   ("M-d" . empty-trash)
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump)
   ("s"   . dirvish-quicksort)
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-j" . dirvish-fd-jump))
  :custom
  (dirvish-quick-access-entries
   '(("h" "~/"                                          "Home")
     ("d" "~/dump/"                                     "Downloads")
     ("w" "~/workstation/projects/work/"                "Work Projects")
     ("s" "~/workstation/projects/sandbox/"             "Work Sandbox")
     ("r" "~/workstation/projects/sandbox/"             "Work R0esources")
     ("m" "/mnt/"                                       "Drives")
     ("t" "~/.local/share/Trash/files/"                 "TrashCan")))
  :config
  (setf dirvish-reuse-session nil)
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(all-the-icons file-time file-size collapse subtree-state vc-state git-msg))
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group"))

;; Terminal
(use-package eat
  :bind
  ("C-M-<return>" . eat)
  (:map eat-semi-char-mode-map ("M-o" . ace-window)))

;;; Keyboard
(provide 'user-system)
;;; user-operating-system.el ends here
