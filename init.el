;; init.el - Main configuration file, used for setting up packages, keybindings, and behavior.
;; Copyright (C) 2023-2025 Sohaib Mahmood
;; Homepage: https://github.com/smahm006/emacs
;; Code:

(use-package emacs
  :ensure nil
  :custom
  ;; User details
  (user-full-name "Sohaib Mahmood")                     ; Set the full name of the current user
  (user-mail-address "soh.mahmood@fastmail.com")        ; Set the email address of the current user
  
  ;; Startup
  ;; Emacs does a lot of things at startup and here, we disable pretty much everything.
  (inhibit-splash-screen t)                            ; Disable startup screens and messages
  (inhibit-startup-buffer-menu t)                      ; Disable display of buffer list when more than 2 files are loaded
  (inhibit-startup-echo-area-message t)                ; Disable initial echo message
  (inhibit-startup-message t)                          ; Disable startup message
  (inhibit-startup-screen t)                           ; Disable start-up screen
  (initial-scratch-message "")                         ; Empty the initial *scratch* buffer

  ;; Dialogs
  ;; use simple text prompts
  (use-dialog-box nil)                                 ; Don't pop up UI dialogs when prompting
  (use-file-dialog nil)                                ; Don't use UI dialogs for file search
  (use-short-answers t)                                ; Replace yes/no prompts with y/n
  (confirm-nonexistent-file-or-buffer nil)             ; Ok to visit non existent files

  ;; Default mode
  ;; Default & initial mode is text.
  (initial-major-mode 'fundamental-mode)               ; Initial mode is text
  (default-major-mode 'fundamental-mode)               ; Default mode is text

  ;; Performance
  ;; https://github.com/alexluigit/dirvish/blob/main/docs/.emacs.d.example/early-init.el
  (read-process-output-max (* 1024 1024))              ; Increase how much is read from processes in a single chunk.
  (select-active-regions 'only)                        ; Emacs hangs when large selections contain mixed line endings.
  (vc-handled-backends '(Git SVN))                     ; Remove unused VC backend

  ;; Miscellaneous
  (native-comp-async-report-warnings-errors 'silent)   ; Disable native compiler warnings
  (fringes-outside-margins t)                          ; DOOM: add some space between fringe it and buffer.
  (windmove-mode nil)                                  ; Diasble windmove mode
  (comment-auto-fill-only-comments t)                  ; Use auto fill mode only in comments
  (custom-buffer-done-kill t)                          ; Kill custom buffer when done
  :init
  ;; Modify width and height of frames
  (modify-all-frames-parameters '((width . 200)
                                  (height . 50)))
  :hook
  (kill-emacs . (lambda () (setq kill-ring (mapcar 'substring-no-properties kill-ring)))))

(use-package emacs
  :ensure nil
  :bind
  (("<f5>" . smahm006/reload-config))
  :preface
  ;; Non-interactive
  (defun smahm006/emacs.d (path)
    "Return the full path pointing to user-emacs-directory"
    (expand-file-name path user-emacs-directory))
  (defun smahm006/mkdir (dir-path)
    "Make directory in DIR-PATH if it doesn't exist."
    (unless (file-exists-p dir-path)
      (make-directory dir-path t)))
  (defun smahm006/location ()
    "Return 'home' if system-name starts with 'sm-', otherwise return 'work'."
    (if (string-match-p "^sm-" (system-name))
    	"home"
      "work"))
  ;; Interactive    
  (defun smahm006/reload-config ()
    "Reload init file, which will effectively reload everything"
    (interactive)
    (load-file (expand-file-name "init.el" user-emacs-directory)))
  (global-set-key (kbd "<f5>") 'smahm006/reload-config)
  (defun smahm006/revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm)))

(use-package emacs
  :ensure nil
  :bind
  (("C-c" . smahm006/main-map))
  :preface
  (defvar smahm006/main-map (make-sparse-keymap) "key-map for leader key")
  (defvar smahm006/buffer-map (make-sparse-keymap) "key-map for buffer commands")
  (defvar smahm006/file-map (make-sparse-keymap) "key-map for file commands")
  (defvar smahm006/version-control-map (make-sparse-keymap) "key-map for version control commands"))

(use-package use-package
  :ensure nil
  :custom
  (use-package-always-ensure t)    ;; Always make sure package is downloaded
  (use-package-always-defer t)     ;; Defer package Enable lazy loading per default
  :config
  ;; Load packages from these archives
  (setq package-archives '(("elpa" . "https://elpa.gnu.org/packages/")
                           ("melpa" . "https://melpa.org/packages/")
                           ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  ;; Highest number gets priority (what is not mentioned has priority 0)
  (setq package-archive-priorities
    	'(("gnu-elpa" . 3)
          ("melpa" . 2)
          ("nongnu" . 1)))
  ;; Make use-package more verbose when `--debug-init` flag is passed
  (when init-file-debug
    (setq use-package-verbose t
	  use-package-expand-minimally nil
	  use-package-compute-statistics t
	  jka-compr-verbose t
	  warning-minimum-level :warning
	  byte-compile-warnings t
	  byte-compile-verbose t
	  native-comp-warning-on-missing-source t
	  debug-on-error t)))

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package exec-path-from-shell
  :custom
  (epg-pinentry-mode 'loopback)
  (exec-path-from-shell-variables '("PATH" "SHELL" "GOPATH"))
  :config
  (setenv "SSH_AUTH_SOCK" (string-chop-newline (shell-command-to-string "gpgconf --list-dirs agent-ssh-socket")))
  (exec-path-from-shell-initialize))

(use-package epa-file
  :ensure nil
  :init
  (epa-file-enable))

(use-package no-littering
  :demand t
  :init
  ;; Store backup and auto-save files in no-littering-var-directory
  (setq no-littering-etc-directory (expand-file-name (format "%s/emacs/etc/" xdg-data)))
  (smahm006/mkdir no-littering-etc-directory)
  (setq no-littering-var-directory (expand-file-name (format "%s/emacs/var/" xdg-data)))
  (smahm006/mkdir no-littering-etc-directory)
  (setq no-littering-cache-directory (expand-file-name (format "%s/emacs/etc" xdg-cache)))
  (smahm006/mkdir no-littering-etc-directory)
  (no-littering-theme-backups)
  ;; Store customization file in no-littering-var-directory
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (when (file-exists-p custom-file) (load custom-file))
  ;; Store cookies in cache directory
  (setq url-cookie-file no-littering-cache-directory)
  ;; Store lock files in in no-littering-var-directory
  (let ((dir (no-littering-expand-var-file-name "lock-files/")))
    (smahm006/mkdir dir)
    (setq lock-file-name-transforms `((".*", dir t)))))
