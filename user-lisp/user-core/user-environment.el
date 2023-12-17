;;; user-environment -- Environment variable

;;; Commentary:

;; Loads bash environment defaults

;;; Code:

(require 'use-package)

;; Load environment variables from the shell
(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-variables '("PATH" "SHELL" "GOPATH"))
  :config
  (exec-path-from-shell-initialize))


;;; Keyboard
(provide 'user-environment)
;;; user-operating-system.el ends here
