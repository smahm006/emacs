;;; user-agenda -- Org mode and time management suite configuration

;;; Commentary:

;; Provides packages which enhance org mode experience

;;; Code:

(require 'use-package)

(use-package pomodoro
  :bind (("C-c t t" . pomodoro-start)
         ("C-c t s" . pomodoro-stop)
         ("C-c t p" . pomodoro-pause)
         ("C-c t r" . pomodoro-resume))
  :custom
  (pomodoro-work-cycle "🍅 ")
  (pomodoro-work-time 45)
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
         ("C-c c" . org-capture)
         (:map org-mode-map (("M-<return>" . org-meta-return))))
  :custom
  (org-log-done 'time)
  (org-agenda-files '("~/office/agenda"))
  (org-return-follows-link  t)
  (org-enforce-todo-dependencies t)
  (org-pretty-entities t)
  (org-hide-emphasis-markers t)
  (org-startup-with-inline-images t)
  (org-image-actual-width '(300))
  (org-use-speed-commands t)
  :config
  (setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d!)" "CANCELLED(c)" )))
  (setq org-capture-templates
        '(
          ("t" "Task"
         entry (file+headline "~/office/agenda/jir.org" "Jira Task")
         "* TODO [#B] %?\n:Created: %T\n%i\n%a\nProposed Solution: "
         :empty-lines 0)
        )))

(use-package org-superstar
  :hook
  (org-mode . org-superstar-mode)
  :config
  ;;(setq org-superstar-special-todo-items t)
  )

(use-package org-ql)

(defun org_list ()
  (interactive)
  (let ((epics (org-ql-search "~/office/agenda/jira.org" `(level 2))))
        (message epics)))


(provide 'user-agenda)
;;; user-agenda.el ends here
