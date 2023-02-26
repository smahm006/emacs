;;; user-org -- Org mode configuration

;;; Commentary:

;; Provides packages which enhance org mode experience

;;; Code:

(require 'use-package)

(use-package org
  :ensure nil
  :bind (("C-c a" . org-agenda)
         ("C-c l"  . org-store-link)
         ("C-c c" . org-capture)))

(provide 'user-org)
;;; user-org.el ends here
