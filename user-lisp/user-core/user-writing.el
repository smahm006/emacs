;;; user-writing -- Common writing configuration.

(use-package jinx
  :init
  (global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-correct-all)))

(use-package org
  :ensure nil
  :mode (("\\.org" . org-mode))
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  (org-mode . jinx-mode)
  :bind (("C-c o a" . org-agenda)
         ("C-c o l"  . org-store-link)
         ("C-c o c" . org-capture)
         (:map org-mode-map (("M-<return>" . org-meta-return))))
  :custom
  (org-log-done 'time)
  (org-return-follows-link  t)
  (org-enforce-todo-dependencies t)
  (org-pretty-entities t)
  (org-hide-emphasis-markers t)
  (org-startup-with-inline-images t)
  (org-image-actual-width '(300))
  (org-use-speed-commands t)
  :config
  (custom-set-faces
   '(org-document-title  ((t (:underline nil :height 2.0))))
   '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
   '(org-level-2 ((t (:inherit outline-2 :height 0.9))))
   '(org-level-3 ((t (:inherit outline-3 :height 0.8))))
   '(org-level-4 ((t (:inherit outline-4 :height 0.7))))
   '(org-level-5 ((t (:inherit outline-5 :height 0.6))))))

(use-package org-superstar
  :hook
  (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-remove-leading-stars t)
  (setq org-superstar-headline-bullets-list '("◉" "○" "■" "◆" "▲" "▶"))
  (setq org-superstar-item-bullet-alist
        '((?+ . ?•)
          (?* . ?➤)
          (?- . ?–))))

(use-package olivetti
  :config
  (setq olivetti-body-width 0.65)
  (setq olivetti-minimum-body-width 72)
  (setq olivetti-recall-visual-line-mode-entry-state t))

(provide 'user-writing)
;;; user-writing.el ends here
