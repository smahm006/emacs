;;; early-init -- Editor environment initialisation script.

;;; Commentary:

;; This initialisation script is evaluated before the main initialisation script
;; to ensure that package management is configured and the load path includes
;; user modules.

;;; Code:
(require 'package)
(require 'cl-lib)

(setq read-process-output-max (* 1024 1024))
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

;; Never load site-specific files
(setq inhibit-default-init t)

;; Follow any symlink leading up to the file
(setq find-file-visit-truename t)

;; Configure package archives
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

;; Change the directory where packages are installed.
(setq package-user-dir (locate-user-emacs-file "remote-lisp"))

;; Initialise the package management system.
(package-initialize)

;; Keep the configuration directory clean.
(setq no-littering-etc-directory (locate-user-emacs-file "local/config/"))
(setq no-littering-var-directory (locate-user-emacs-file "local/data/"))
(unless (package-installed-p 'no-littering)
  (package-refresh-contents nil)
  (package-install 'no-littering))
(require 'no-littering)

;; Ensure that higher-level package management support is installed.
(unless (package-installed-p 'use-package)
  (package-refresh-contents nil)
  (package-install 'use-package))
(require 'use-package)

;; Always install packages when they are not already installed.
(setq use-package-always-ensure t)

;; Override Major Mode keybinds with my own
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-<return>") 'vterm-with-virtualenv)
    (define-key map (kbd "C-M-<return>") (lambda () (interactive) (vterm-dedicated-with-virtualenv) (balance-windows)))
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override anoying major modes."
  :init-value t
  :lighter " my-keys")

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(defun my-keys-have-priority (_file)
  "Try to ensure that my keybindings retain priority over other minor modes.

Called via the `after-load-functions' special hook."
  (unless (eq (caar minor-mode-map-alist) 'my-keys-minor-mode)
    (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
      (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist mykeys))))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
(add-hook 'after-load-functions 'my-keys-have-priority)
(my-keys-minor-mode 1)

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

;; Get full path of the current buffer
(defun filename ()
    (interactive)
    (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

;; Remove pesky CL warning
(setq byte-compile-warnings '(cl-functions))

;; Add user modules to the load path.
(add-to-list 'load-path (locate-user-emacs-file "user-lisp"))
(add-to-list 'load-path (locate-user-emacs-file "user-lisp/user-machine"))
(add-to-list 'load-path (locate-user-emacs-file "user-lisp/user-language"))

(provide 'early-init)
;;; early-init.el ends here
