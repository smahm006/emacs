;;; user-environment -- Environment variable

;;; Commentary:

;; Loads bash environment defaults

;;; Code:

(require 'use-package)

(defun keychain-refresh-environment ()
  "Set ssh-agent and gpg-agent environment variables.
Set the environment variables `SSH_AUTH_SOCK', `SSH_AGENT_PID'
and `GPG_AGENT' in Emacs' `process-environment' according to
information retrieved from files created by the keychain script."
  (interactive)
  (let* ((ssh (shell-command-to-string (format "keychain --absolute --dir %s/keychain -q --noask --agents ssh --eval" (getenv "XDG_RUNTIME_DIR"))))
         (gpg (shell-command-to-string (format "keychain --absolute --dir %s/keychain -q --noask --agents gpg --eval" (getenv"XDG_RUNTIME_DIR")))))
    (list (and ssh
               (string-match "SSH_AUTH_SOCK[=\s]\\([^\s;\n]*\\)" ssh)
               (setenv       "SSH_AUTH_SOCK" (match-string 1 ssh)))
          (and ssh
               (string-match "SSH_AGENT_PID[=\s]\\([0-9]*\\)?" ssh)
               (setenv       "SSH_AGENT_PID" (match-string 1 ssh)))
          (and gpg
               (string-match "GPG_AGENT_INFO[=\s]\\([^\s;\n]*\\)" gpg)
               (setenv       "GPG_AGENT_INFO" (match-string 1 gpg))))))

;; Load environment variables from the shell
(use-package exec-path-from-shell
  :init
  ;; Refresh keychain
  (keychain-refresh-environment)
  :custom
  (exec-path-from-shell-variables '("PATH" "SHELL" "GOPATH"))
  :config
  (exec-path-from-shell-initialize))


;;; Keyboard
(provide 'user-environment)
;;; user-operating-system.el ends here
