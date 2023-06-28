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
  (setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
  (setq tramp-verbose 1))

(use-package docker-tramp)

;; Runs REST queries from a query sheet and pretty-prints responses.
(use-package restclient
  :mode ("\\.http$" . restclient-mode))

(provide 'user-networking)
;;; user-networking.el ends here
