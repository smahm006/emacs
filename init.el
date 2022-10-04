;;; init -- Initialisation script.

;;; Commentary:

;; All initialisation is contained within the `user-lisp` path in a set
;; of modules prefixed with `user`.  This script ensures that they are
;; imported in something resembling a correct order.

;;; Code:

;; Backwards compatibility for systems without `early-init.el` support.
(require 'early-init (concat user-emacs-directory "early-init.el"))

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
(require 'user-operating-system)
(require 'user-networking)
(require 'user-container)
(require 'user-project-management)
(require 'user-version-control)

;; Programming languages.
;;(require 'user-language-c-cpp)
(require 'user-language-python)
(require 'user-language-go)
(require 'user-language-rust)
(require 'user-language-ruby)
(require 'user-language-config)

;; Local and non-version-controlled customisation
(setq custom-file (no-littering-expand-etc-file-name "custom.el"))
(when (file-exists-p custom-file) (load custom-file))

(provide 'init)
;;; init.el ends here
