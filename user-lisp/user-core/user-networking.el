;;; user-networking -- Transparent and interactive network clients.

;;; Commentary:

;; Provides transparent and explicit access to remote resources, as well
;; as documentation and other network utilities.

;;; Code:

(require 'use-package)

;; Transparent remote access
(use-package tramp
  :ensure nil
  :init
  (setq tramp-default-method 'ssh)
  (setq remote-file-name-inhibit-cache nil)
  (setq vc-handled-backends '(Git))
  (setq projectile-auto-update-cache nil)
  (setq projectile-dynamic-mode-line nil)
  (setq projectile-mode-line "Projectile")
  (setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
  (setq tramp-verbose 1)
  :config
  (defun basic-remote-try-completion (string table pred point)
    (and (vertico--remote-p string)
         (completion-basic-try-completion string table pred point)))
  (defun basic-remote-all-completions (string table pred point)
    (and (vertico--remote-p string)
         (completion-basic-all-completions string table pred point)))
  (add-to-list
   'completion-styles-alist
   '(basic-remote basic-remote-try-completion basic-remote-all-completions nil))
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic-remote partial-completion))))
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(use-package docker-tramp)

;; Nginx Mode
(use-package nginx-mode)

;; Runs REST queries from a query sheet and pretty-prints responses.
(use-package restclient
  :mode ("\\.http$" . restclient-mode))

(provide 'user-networking)
;;; user-networking.el ends here
