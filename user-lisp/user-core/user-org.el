;;; user-org -- Org mode configuration

;;; Commentary:

;; Provides packages which enhance org mode experience

;;; Code:

(require 'use-package)

(use-package pomodoro
  :bind (("C-c t t" . pomodoro-start)
         ("C-c t s" . pomodoro-stop)
         ("C-c t p" . pomodoro-pause)
         ("C-c t r" . pomodoro-resume))
  :config
  (pomodoro-add-to-mode-line))

(use-package org
  :ensure nil
  :mode (("\\.org" . org-mode))
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  :bind (("C-c a" . org-agenda)
         ("C-c l"  . org-store-link)
         ("C-c c" . org-capture))
  :custom
  (org-log-done 'time)
  (org-agenda-files "~/office/agenda")
  (org-return-follows-link  t)
  :config
  (setq org-capture-templates
        '(
          ("c" "Code To-Do"
         entry (file+headline "~/office/agenda/todos.org" "Code Related Tasks")
         "* TODO [#B] %?\n:Created: %T\n%i\n%a\nProposed Solution: "
         :empty-lines 0)

        )))

(provide 'user-org)
;;; user-org.el ends here
