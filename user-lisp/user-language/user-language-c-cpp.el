;;; user-language-c-cpp -- C/C++ development environment.

;;; Commentary:

;; Provides an integrated development environment for C/C++, with
;; completion and syntax checking.

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)

(use-package cc-mode
  :ensure nil
  :mode (("\\.c" . c-mode))
  :hook
  (c-mode . eglot-ensure)
  (c-mode . corfu-mode)
  (c-mode . display-line-numbers-mode)
  (c-mode . eldoc-mode)
  (c-mode . electric-pair-mode)
  (c-mode . flymake-mode)
  (c-mode . flyspell-prog-mode)
  (c-mode . hungry-delete-mode)
  (c-mode . rainbow-delimiters-mode))

(use-package c++-mode
  :ensure nil
  :mode (("\\.cpp" . c-mode))
  :hook
  (c++-mode . eglot-ensure)
  (c++-mode . corfu-mode)
  (c++-mode . display-line-numbers-mode)
  (c++-mode . eldoc-mode)
  (c++-mode . electric-pair-mode)
  (c++-mode . flymake-mode)
  (c++-mode . flyspell-prog-mode)
  (c++-mode . hungry-delete-mode)
  (c++-mode . rainbow-delimiters-mode))


(provide 'user-language-c-cpp)
;;; user-language-c-cpp.el ends here
