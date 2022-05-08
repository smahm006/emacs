;;; user-machine-euclid -- Configuration for my personal workstation.

;;; Commentary:

;; Configures the

;;; Code:

;; Appearance
(defconst user-setting-theme-package 'monokai-theme)
(defconst user-setting-theme 'monokai)
(defconst user-setting-font "Hack-14")
(defconst user-setting-menu-bar-mode -1)

;; System integration
(defconst user-setting-load-path-from-shell nil)

;; Project management
;;(defconst user-setting-project-indexing-method 'hybrid)
;;(defconst user-setting-project-search-path '("~/workstation"))

;; Revision control
;;(defconst user-setting-repository-path '(("~/workstation" . 1)))

;; Erlang
;;(defconst user-setting-elixir-language-server nil)

(provide 'user-machine-mini)
;;; user-machine-euclid.el ends here
