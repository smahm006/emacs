;;; user-language-robotf -- Robot Framework development environment.

;;; Commentary:

;; Provides an integrated development environment of Robot files, with most
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)

(use-package robot-mode
  :mode (("\\.robot" . robot-mode))
  :hook
  (robot-mode . corfu-mode)
  (robot-mode . display-line-numbers-mode)
  (robot-mode . eldoc-mode)
  (robot-mode . electric-pair-mode)
  (robot-mode . flymake-mode)
  (robot-mode . flyspell-prog-mode)
  (robot-mode . hungry-delete-mode)
  (robot-mode . rainbow-delimiters-mode)
  (robot-mode . pyvenv-mode)
  (robot-mode . pyvenv-autoload))

;; Virtual environment setup
(use-package pyvenv
  :config
  (setq pyvenv-default-virtual-env-name "~/workstation/architecture/.pyvenv_default"))

(defun pyvenv-setup ()
  "Install venv virtual environment with pyright+black+flake8 and requirements.txt if it exists."
  (interactive)
  (let* ((pdir (file-name-directory buffer-file-name)) (pvenv (concat pdir "venv")))
  (progn
    (shell-command (concat "python3 -m venv " pvenv))
    (compile (concat "source " pvenv "/bin/activate" " && " "pip3 install pyright black flake8" " && " "pip3 install -r requirements.txt || true"))
    (pyvenv-activate pvenv))))

;; Check for venv, if none then choose default
(defun pyvenv-autoload ()
  (unless pyvenv-mode
  (pyvenv-mode))
  (let* ((pdir (locate-dominating-file default-directory "venv/bin/activate")) (pvenv (concat pdir "venv")))
    (if pdir
        (pyvenv-activate pvenv)
    (pyvenv-activate pyvenv-default-virtual-env-name))))

(defun robot-compile ()
  "Compile current buffer file with python."
  (interactive)
  (compile (format "robot %s" (filename))))

;;; Keyboard
(with-eval-after-load 'robot-mode
  (define-key robot-mode-map (kbd "C-c r r") #'robot-compile))

(provide 'user-language-robotfw)
;;; user-language-robotfw.el ends here
