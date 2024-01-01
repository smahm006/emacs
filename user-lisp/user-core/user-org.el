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
   '(org-level-1 ((t (:inherit outline-1 :height 1.75))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.5))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.25))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 0.75))))))

(defvar writing-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap evil-previous-line] 'evil-previous-visual-line)
    (define-key map [remap evil-next-line] 'evil-next-visual-line)
    (define-key map [?-] 'typopunct-insert-typographical-dashes)
    map))

(define-minor-mode writing-mode ()
  :keymap writing-mode-map
  :group 'writing
  :global nil

  (setq-local org-startup-folded nil)
  (setq-local org-level-color-stars-only nil)
  (setq-local org-hide-leading-stars t)

  ;; org number headlines
  (setq-local org-num-skip-unnumbered t)
  (setq-local org-num-skip-footnotes t)
  (setq-local org-num-face nil)
  (setq-local line-spacing 2)

  ;; Have org number headlines
  (setq-local org-superstar-headline-bullets-list '(" "))

  ;; Org indent
  (org-indent-mode 1)

  ;; Center the buffer
  (olivetti-mode 1)
  ;; Hide title / author ... keywords
  (setq-local org-hidden-keywords '(title author date startup))

  ;; Spelling stuff
  (flyspell-mode-on)

  (git-gutter-mode -1) ;; too slow for large buffers.
  nil " Writing" '())

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

(provide 'user-org)
;;; user-agenda.el ends here
