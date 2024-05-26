;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 100 1024 1024))

;; Move native compilation cache directory to xdg-cache
(when (boundp 'native-comp-eln-load-path)
    (startup-redirect-eln-cache
      (expand-file-name (format "%s/emacs/eln-cache/" "~/.cache"))))

;; Load confing.el or create from config.org if not exist
(if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
    (load-file (expand-file-name "config.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 10 1000 1000))

;;; init.el ends here
