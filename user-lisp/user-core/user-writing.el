;;; user-writing -- Writing and office tools for viewing and editing documents

;;; Commentary:

;; Provides common pdf viewing editing behaviour

;;; Code:

(require 'use-package)

;; PDF viewer and tools
(use-package pdf-tools
  ;; :pin manual ;; don't reinstall when package updates
  :mode  ("\\.pdf\\'" . pdf-view-mode)
  :config
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t)
  (pdf-tools-install :no-query)
  (add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
  (require 'pdf-occur))

;; typo
;; Mode for typographical editing.
(use-package typo
  :commands typo-mode
  :config (setq-default typo-language "English"))
  ;;:init (add-hook 'text-mode-hook #'typo-mode))

;; Distraction-free writing.
(use-package writeroom-mode
  :commands (writeroom-mode)
  :config
  (add-to-list 'writeroom-global-effects 'visual-line-mode)
  (setq writeroom-restore-window-config t
        writeroom-width 100))

;; olivetti -- similar to writeroom but a simple minor mode
(use-package olivetti
  :if window-system
  ;;:hook (text-mode . olivetti-mode)
  :bind ("C-c o" . olivetti-mode)
  :custom
  (olivetti-minimum-body-width 80)
  (olivetti-body-width 0.66))

(use-package flyspell
  :commands flyspell-mode
  :hook (text-mode . flyspell-mode)
  :config
  (setq flyspell-issue-message-flag nil)
  (setq flyspell-issue-welcome-flag nil))

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(provide 'user-writing)
;;; user-writing.el ends here
