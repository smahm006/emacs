;;; user-operating-system -- Operation system integration.

;;; Commentary:

;; Provides operating system integration, filesystem navigation and
;; management, and terminal support.

;;; Code:
(require 'use-package)

;; Password store
(use-package pass)

(use-package epa-file
  :ensure nil
  :config
  (setq epa-pinentry-mode 'loopback)
  (setq password-cache-expiry (* 60 15)))

;; Dired File Manager
(use-package dired
  :ensure nil
  :config
  (setf dired-kill-when-opening-new-dired-buffer t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq dired-dwim-target t)
  (setq dired-listing-switches
        "-laGh1v --group-directories-first --time-style=long-iso"))

;; Dired extras
(use-package dired-x
  :after dired
  :ensure nil)

;; Dired fonts
(use-package diredfl
  :after dired
  :hook
  (dired-mode . diredfl-mode))

;; Dired icons?
(use-package all-the-icons-dired
  :diminish all-the-icons-dired-mode
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; Filter files/directories
(use-package dired-narrow
  :after dired
  :bind
  (:map dired-mode-map
        ("C-c C-n" . dired-narrow)))

;; Using i in dired puts diredtory below
(use-package dired-subtree
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package dired-sidebar
  :after dired
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (setq dired-sidebar-face '(:height 120))
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "-")
  (setq dired-sidebar-theme 'icons)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; Terminal
(use-package vterm
  :commands vterm
  :bind
  (("C-<return>" . (lambda () (interactive) (vterm-dedicated-with-virtualenv) (balance-windows)))
   ("M-<return>" . vterm-with-virtualenv))
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
    (if buffer-file-name
        (let* ((command (concat "cd " (file-name-directory buffer-file-name))))
          (vterm-toggle)
          (vterm--goto-line -1)
          (vterm-send-string command)
          (vterm-send-return))
      (vterm-toggle))
    (when pyvenv-virtual-env
      (let* ((command (concat (replace-regexp-in-string "\/.*:.*:" "" (concat "source " (concat pyvenv-virtual-env "bin/activate"))) " && history -d -3--1")))
        (vterm--goto-line -1)
        (vterm-send-string command)
        (vterm-send-return)))))


(use-package multi-vterm
  :config
  (setq multi-term-program-switches "--login"))

(use-package vterm-toggle)

;; Load recursively all .el files in directory
(defun load-directory (directory)
(dolist (element (directory-files-and-attributes directory nil nil nil))
  (let* ((path (car element))
         (fullpath (concat directory "/" path))
         (isdir (car (cdr element)))
         (ignore-dir (or (string= path ".") (string= path ".."))))
    (cond
     ((and (eq isdir t) (not ignore-dir))
      (sm/load-directory fullpath))
     ((and (eq isdir nil)
           (string= (substring path -3) ".el")
           (not (string-match "^\\." path)))
      (load (file-name-sans-extension fullpath)))))))

;; Re-open file as sudo
(defun reopen-this-file-as-sudo ()
  (interactive)
  (let ((p (point)))
    (when-let ((file-name (filename)))
      (find-alternate-file (concat "/sudo::" file-name))
      (goto-char p))))

;;; Keyboard
(provide 'user-operating-system)
;;; user-operating-system.el ends here
