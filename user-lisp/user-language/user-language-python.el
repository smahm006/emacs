;;; user-language-python -- Python development environment.

;;; Commentary:

;; Provides an integrated development environment for Python, with most
;; functionality provided by the language server protocol module.

;;; Code:

(require 'use-package)
(require 'user-development)
(require 'user-editing)
(require 'user-hooks)

(use-package python
  :ensure nil
  :hook
  (python-mode . eglot-ensure)
  (python-mode . corfu-mode)
  (python-mode . display-line-numbers-mode)
  (python-mode . auto-fill-mode)
  (python-mode . eldoc-mode)
  (python-mode . electric-pair-mode)
  (python-mode . hl-todo-mode)
  (python-mode . flymake-mode)
  (python-mode . flyspell-prog-mode)
  (python-mode . tempel-setup-capf)
  (python-mode . hungry-delete-mode)
  (python-mode . rainbow-delimiters-mode)
  (python-mode . user-auto-fill-only-comments)
  (python-mode . pyvenv-mode)
  (python-mode . blacken-mode)
  (python-mode . pyvenv-autoload)
  :config
  (setq python-indent-offset 4)
  (setq lsp-diagnostic-package :none)
  (setq-local flycheck-checker 'python-flake8))

;; Major mode for editing pip requirements files
(use-package pip-requirements)

;; Python Code Formatter
(use-package blacken)

;; Virtual environment setup
(use-package pyvenv
  :config
  (setq pyvenv-default-virtual-env-name "~/workstation/architecture/.pyvenv_default"))

(defun setup_pyvenv ()
  (interactive)
  (let* ((pdir (file-name-directory buffer-file-name)) (pvenv (concat pdir ".pyvenv")))
  (progn
    (shell-command (concat "virtualenv " pvenv))
    (compile (concat "source " pvenv "/bin/activate" " && " "pip3 install pyright black flake8" " && " "pip3 install -r requirements.txt || true"))
    (pyvenv-activate pvenv))))

;; Check for venv, if none then choose default
(defun pyvenv-autoload ()
  (unless pyvenv-mode
  (pyvenv-mode))
  (let* ((pdir (locate-dominating-file default-directory ".pyvenv/bin/activate")) (pvenv (concat pdir ".pyvenv")))
    (if pdir
        (pyvenv-activate pvenv)
    (pyvenv-activate pyvenv-default-virtual-env-name))))

;; Run Python Code
(defun python-compile ()
  (interactive)
  (compile (format "python %s" (filename))))

;;; Keyboard
(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c r r") #'python-compile))

  (provide 'user-language-python)
;;; user-language-python.el ends here
