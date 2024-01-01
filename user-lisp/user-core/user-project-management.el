;;; user-project-management -- Project management configuration.

(use-package project
  :ensure nil
  :config
  (customize-set-variable 'project-find-functions
                          (list #'project-try-vc
                                #'project-local-try-local))
  (defgroup project-local nil
    "Local, non-VC-backed project.el root directories."
    :group 'project)

  (defcustom project-local-identifier ".project"
    "Filename(s) that identifies a directory as a project."
    :type '(choice (string :tag "Single file")
                   (repeat (string :tag "Filename")))
    :group 'project-local)

  (cl-defmethod project-root ((project (head local)))
    "Return root directory of current PROJECT."
    (cdr project))

  (defun project-local-try-local (dir)
    "Determine if DIR is a non-VC project."
    (if-let ((root (if (listp project-local-identifier)
                       (seq-some (lambda (n)
                                   (locate-dominating-file dir n))
                                 project-local-identifier)
                     (locate-dominating-file dir project-local-identifier))))
        (cons 'local root))))


(provide 'user-project-management)
;;; user-project-management.el ends here
