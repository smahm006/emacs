;;; user-environment -- Environment variable

;;; Commentary:

;; Loads bash environment defaults

;;; Code:

;; Load environment variables from the shell

(use-package exec-path-from-shell
  :custom
  (epg-pinentry-mode 'loopback)
  (exec-path-from-shell-variables '("PATH" "SHELL" "GOPATH"))
  :config
  (setenv "SSH_AUTH_SOCK" (string-chop-newline (shell-command-to-string "gpgconf --list-dirs agent-ssh-socket")))
  ;; (setenv "GPG_TTY" "/dev/pts/0")
  (exec-path-from-shell-initialize))

;;; Keyboard
(provide 'user-environment)
;;; user-operating-system.el ends here
