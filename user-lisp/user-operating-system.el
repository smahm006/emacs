;;; user-operating-system -- Operation system integration.

;;; Commentary:

;; Provides operating system integration, filesystem navigation and
;; management, and terminal support.

;;; Code:

(require 'use-package)

;; Better performance
(setq read-process-output-max (* 1024 1024))
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

;; Password store
(use-package pass)

(use-package epa-file
  :ensure nil
  :config
  (setq epa-pinentry-mode 'loopback)
  (setq password-cache-expiry (* 60 15)))

;; Terminal
(use-package vterm
  :config
  (setq vterm-kill-buffer-on-exit t)
  (setq vterm-max-scrollback 5000)
  (setq confirm-kill-processes nil)
  (setq hscroll-margin 0)
  (defun vterm-with-virtualenv ()
    "Automatically activate virtualenv if active"
    (interactive)
    (multi-vterm)
    (when pyvenv-virtual-env
      (let* ((command (replace-regexp-in-string "\/.*:.*:" "" (concat "source " (concat pyvenv-virtual-env "bin/activate")))))
        (vterm--goto-line -1)
        (vterm-send-string command)
        (vterm-send-return))))
  (defun vterm-dedicated-with-virtualenv ()
    "Automatically activate virtualenv if active"
    (interactive)
    (multi-vterm-dedicated-open)
    (when pyvenv-virtual-env
      (let* ((command (replace-regexp-in-string "\/.*:.*:" "" (concat "source " (concat pyvenv-virtual-env "bin/activate")))))
        (vterm--goto-line -1)
        (vterm-send-string command)
        (vterm-send-return)))))

(use-package multi-vterm
  :config
  (setq multi-term-program-switches "--login"))

;; Don't change cursor from uline to block in vterm
(advice-add #'vterm--redraw :around (lambda (fun &rest args) (let ((cursor-type cursor-type)) (apply fun args))))

;; Load environment variables from the shell
(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-variables '("PATH" "SHELL" "GOPATH" "LSP_USE_PLISTS"))
  :config
  (exec-path-from-shell-initialize))

;; Re-open file as sudo
(defun reopen-this-file-as-sudo ()
  (interactive)
  (let ((p (point)))
    (when-let ((file-name (filename)))
      (find-alternate-file (concat "/sudo::" file-name))
      (goto-char p))))

;; refresh keychain
;;;###autoload
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

;;; Keyboard
(provide 'user-operating-system)
;;; user-operating-system.el ends here
