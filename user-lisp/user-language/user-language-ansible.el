;;; user-language-ansible -- Ansible development environment.

;;; Commentary:

;; Provides an integrated development environment for Ansible

;;; Code:

(require 'use-package)

(require 'user-development)
(require 'user-editing)

;; Bash language support
(use-package ansible
  :hook
  (yaml-mode anisble)
  :bind (:map yaml-mode-map
              ("C-c r s" . ansible-check)
              ("C-c r r" . ansible-compile)
              ("C-c r b" . ansible-become-compile)))

(defun ansible-check ()
  "Check for bugs in bash scripts."
  (interactive)
  (compile (format "ansible-playbook --syntax-check %s" (filename))))

(defun ansible-compile ()
  "Compile current buffer file with ansible-playbook."
  (interactive)
  (compile (format "ansible-playbook %s" (filename))))

(defun ansible-become-compile (args)
  "Compile current buffer file as sudo with ansible-playbook."
  (interactive
   (list (read-passwd "Enter become password: ")))
  (compile (format "ansible-playbook --extra-vars 'ansible_become_pass=%s' %s" args (filename) )))

(provide 'user-language-ansible)
;;; user-language-bash.el ends here
