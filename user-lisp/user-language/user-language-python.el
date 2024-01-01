(use-package python
  :ensure nil
  :mode (("\\.py" . python-ts-mode))
  :init
  (setq major-mode-remap-alist '((python-mode . python-ts-mode)))
  :hook
  (python-ts-mode . eglot-ensure)
  (python-ts-mode . corfu-mode)
  (python-ts-mode . display-line-numbers-mode)
  (python-ts-mode . eldoc-mode)
  (python-ts-mode . electric-pair-mode)
  (python-ts-mode . flymake-mode)
  (python-ts-mode . flyspell-prog-mode)
  (python-ts-mode . hungry-delete-mode)
  (python-ts-mode . rainbow-delimiters-mode)
  (python-ts-mode . pyvenv-mode)
  (python-ts-mode . blacken-mode)
  (python-ts-mode . pyvenv-autoload)
  :config
  (setq python-indent-offset 4)
  (setq python-indent-guess-indent-offset t)
  (setq python-indent-guess-indent-offset-verbose nil))

;; Formatter
(use-package blacken)

;; Virtual environment setup
(use-package pyvenv
  :config
  (setq pyvenv-default-virtual-env-name "~/workstation/architecture/.pyvenv-global"))

(defun pyvenv-setup ()
  "Install .pyvenv virtual environment with pyright+black+flake8 and requirements.txt if it exists."
  (interactive)
  (let* ((pdir (file-name-directory buffer-file-name)) (pvenv (concat pdir ".pyvenv")))
  (progn
    (shell-command (concat "python3 -m .pyvenv " pvenv))
    (compile (concat "source " pvenv "/bin/activate" " && " "pip3 install pyright black flake8" " && " "pip3 install -r requirements.txt || true"))
    (pyvenv-activate pvenv))))

;; Check for .pyvenv, if none then choose default
(defun pyvenv-autoload ()
  (unless pyvenv-mode
  (pyvenv-mode))
  (let* ((pdir (locate-dominating-file default-directory ".pyvenv/bin/activate")) (pvenv (concat pdir ".pyvenv")))
    (if pdir
        (pyvenv-activate pvenv)
    (pyvenv-activate pyvenv-default-virtual-env-name))))

(defun python-compile ()
  "Compile current buffer file with python."
  (interactive)
  (compile (format "python3 %s" (filename))))

;;; Keyboard
(with-eval-after-load 'python
  (define-key python-ts-mode-map (kbd "C-c r r") #'python-compile))

  (provide 'user-language-python)
;;; user-language-python.el ends here
