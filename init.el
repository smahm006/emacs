;;; init -- Initialisation script.

;;; Commentary:

;; All initialisation is contained within the `user-lisp` path in a set
;; of modules prefixed with `user`.  This script ensures that they are
;; imported in something resembling a correct order.

;;; Code:

(if (display-graphic-p)
    (progn
        ;; General customisation.
        (require 'user-emacs)
        (require 'user-environment)
        (require 'user-appearance)
        (require 'user-buffer)
        (require 'user-navigation)
        (require 'user-completion)
        (require 'user-development)
        (require 'user-editing)
        (require 'user-writing)
        (require 'user-agenda)
        (require 'user-system)
        (require 'user-networking)
        (require 'user-container)
        (require 'user-project-management)
        (require 'user-version-control)
        ;; Programming languages.
        (require 'user-language-c-cpp)
        (require 'user-language-bash)
        (require 'user-language-python)
        (require 'user-language-groovy)
        (require 'user-language-go)
        (require 'user-language-ts)
        (require 'user-language-rust)
        (require 'user-language-ruby)
        (require 'user-language-ansible)
        (require 'user-language-config)
        (require 'user-language-emacs-lisp)
        ;; Local and non-version-controlled customisation
        (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
        (when (file-exists-p custom-file) (load custom-file))
    )
    (progn
        (defun my-kill-emacs ()
            "save buffers, then exit unconditionally"
            (interactive)
            (save-some-buffers nil t)
            (kill-emacs)
        )
        (global-set-key (kbd "C-x C-c") 'my-kill-emacs)
        (setq create-lockfiles nil)
        (setq find-file-visit-truename t)
        (setq ring-bell-function (lambda()))
        (setq create-lockfiles nil)
        (setq make-backup-files nil)
        (menu-bar-mode -1)
        (scroll-bar-mode -1)
        (tool-bar-mode -1)
    )
)

(provide 'init)
;;; init.el ends here
