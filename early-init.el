;;; early-init -- Editor environment initialisation script.

;;; Commentary:

;; This initialisation script is evaluated before the main initialisation script
;; to ensure that package management is configured and the load path includes
;; user modules.

;;; Code:

(require 'package)

;; Set base directories
(setq user-emacs-directory (file-truename "~/.config/emacs"))

(defun emacs.d (path)
  (expand-file-name path user-emacs-directory))

(defun user-data (identifier)
  (expand-file-name identifier (emacs.d "local/data")))

(defun user-config (identifier)
  (expand-file-name identifier (emacs.d "local/config")))

(defun mkdir-p (dir-path)
  "Make directory in DIR-PATH if it doesn't exist."
  (unless (file-exists-p dir-path)
    (make-directory dir-path t)))

(defun filename ()
  "Gets the name of the file the current buffer is based on."
  (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

;; Configure package archives
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Change the directory where packages are installed.
(setq package-user-dir (locate-user-emacs-file "remote-lisp"))

;; Add user modules to the load path.
(add-to-list 'load-path (locate-user-emacs-file "user-lisp/user-core"))
(add-to-list 'load-path (locate-user-emacs-file "user-lisp/user-language"))
(add-to-list 'load-path (locate-user-emacs-file "user-lisp/user-snippet"))
(add-to-list 'load-path (locate-user-emacs-file "user-lisp/user-theme"))

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

(provide 'early-init)
;;; early-init.el ends here
