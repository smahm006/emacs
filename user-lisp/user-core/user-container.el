;;; user-container -- Containerization support

;; Provides common integrated development environment functionality as
;; well as minor modes shared between multiple programming languages.

;;; Code:

(require 'use-package)

(require 'user-completion)

;; Docker
(use-package docker
  :bind
  ("C-c d o" . docker)
  ("C-c d d" . docker-compose-down)
  ("C-c d u" . docker-compose-up))
(use-package dockerfile-mode)
(use-package docker-compose-mode)

;; Vagrant
(use-package vagrant)
(use-package vagrant-tramp)

(provide 'user-container)
;;; user-container.el ends here
