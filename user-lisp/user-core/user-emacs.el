;;; user-emacs -- Emacs behavious configuration.

;;; Code:

(require 'use-package)

(use-package emacs
  :ensure nil
  :init
  ;; Performance related
  (setq read-process-output-max (* 1024 1024))
  (setq gc-cons-threshold most-positive-fixnum)
  (add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 16777216)))

  ;; Never ring the bell. Never.
  (setq ring-bell-function (lambda()))

  ;; Don't disable any commands (e.g. `upcase-region').
  (setq disabled-command-function nil)

  ;; Reduce keystroke echo delay.
  (setq echo-keystrokes 0.001)

  ;; Prevent accindentally killing sesesion
  (setq confirm-kill-emacs 'y-or-n-p)

  ;; Enable y/n answers.
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; Don't use dialog boxes.
  (setq use-dialog-box nil)

  ;; Ignore case for completion.
  (setq completion-ignore-case t
        read-file-name-completion-ignore-case t)

  ;; Automatically scroll compilation window.
  (setq compilation-scroll-output 1)

  ;; Never load site-specific files
  (setq inhibit-default-init t)

  ;; Follow any symlink leading up to the file
  (setq find-file-visit-truename t)

  ;; Remove pesky CL warning
  (setq byte-compile-warnings '(cl-functions))

  ;; Backups
  (defvar my-backups-dir (user-var "backups"))
  (mkdir-p my-backups-dir)
  (setq backup-directory-alist `(("." . "~/.config/emacs/local/data/backups"))
        make-backup-files t
        backup-by-copying t
        version-control t
        delete-old-versions t
        delete-by-moving-to-trash t
        kept-old-versions 6
        kept-new-versions 9
        auto-save-default t
        auto-save-timeout 20
        auto-save-interval 200
        auto-save-file-name-transforms `((".*" "~/.config/emacs/local/data/backups/" t))
        auto-save-list-file-prefix "~/.config/emacs/local/data/backups/")

  ;; Change bookmarks file location.
  (setq bookmark-default-file (user-var "bookmarks"))

  ;; Change save-places file location.
  (setq save-place-file (user-var "places"))

  ;; Disable annoying lock files.b
  (setq create-lockfiles nil)

  ;; Allow pasting selection outside of Emacs.
  (setq x-select-enable-clipboard t)

  ;; Move files to trash when deleting
  (setq trash-directory "~/.local/share/Trash/files")
  (setq delete-by-moving-to-trash t)

  ;; When copying something from outside emacs, save to kill-ring.
  (setq save-interprogram-paste-before-kill t)

    ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Don't change cursor to block
  (advice-add #'vterm--redraw :around (lambda (fun &rest args) (let ((cursor-type cursor-type)) (apply fun args))))

  ;; Vertico commands are hidden in normal buffers.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))


;; Persist history over Emacs restarts.
(use-package savehist
  :init
  (savehist-mode))

;; Refresh buffers automatically when underlying files are changed externally.
(use-package autorevert
  :hook (after-init . global-auto-revert-mode)
  :config (setq auto-revert-interval 1))

;; Add better help functionality
(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h m" . helpful-macro)
   ("C-c C-d" . helpful-at-point)
   ("C-h F" . helpful-function)
   ("C-h C" . helpful-command)))

(provide 'user-emacs)
;;; user-emacs.el ends here
