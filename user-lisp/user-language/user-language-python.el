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
  :init
  (add-hook 'python-mode-hook #'auto-fill-mode)
  (add-hook 'python-mode-hook #'company-mode)
  (add-hook 'python-mode-hook #'display-line-numbers-mode)
  (add-hook 'python-mode-hook #'eldoc-mode)
  (add-hook 'python-mode-hook #'electric-pair-mode)
  (add-hook 'python-mode-hook #'hl-todo-mode)
  (add-hook 'python-mode-hook #'flycheck-mode)
  (add-hook 'python-mode-hook #'flyspell-prog-mode)
  (add-hook 'python-mode-hook #'hungry-delete-mode)
  (add-hook 'python-mode-hook #'lsp-deferred)
  (add-hook 'python-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'python-mode-hook #'user-auto-fill-only-comments)
  (add-hook 'python-mode-hook #'yas-minor-mode)
  (add-hook 'python-mode-hook #'pyvenv-mode)
  (add-hook 'python-mode-hook #'blacken-mode)
  (add-hook 'python-mode-hook #'pyvenv-autoload)
  :config
  (setq python-indent-offset 4)
  (setq lsp-diagnostic-package :none)
  (setq-local flycheck-checker 'python-flake8))

;; Pyright LSP language server
(use-package lsp-pyright
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-pyright)
                   (lsp-deferred)))
  :config
  (setq lsp-pyright-use-library-code-for-types t)
  (setq lsp-pyright-diagnostic-mode "workspace")
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection  "bin/pyright")
                    :major-modes '(python-mode)
                    :remote? t
                    :server-id 'pyright-remote)))

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
