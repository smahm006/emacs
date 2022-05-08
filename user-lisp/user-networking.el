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
  (setq tramp-verbose 1)
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; Nginx Mode
(use-package nginx-mode)

(provide 'user-networking)
;;; user-networking.el ends here
