;;; user-buffer -- Buffer management

;;; Commentary:

;; Provides buffer and corresponding file management

;;; Code:

(require 'use-package)

;; Buffer navigation.
(use-package bufler
  :custom
  (bufler-columns '("Name" "VC" "Path"))
  (bufler-reverse t)
  (bufler-use-cache t)
  (bufler-vc-refresh t)
  (bufler-vc-state t))

;; Window navigation.
(use-package ace-window
  :custom
  (aw-ignore-current t)
  (aw-scope 'frame))


;; Originally from stevey, adapted to support moving to a new directory.
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     ;; Disable ido auto merge since it too frequently jumps back to the original
     ;; file name if you pause while typing. Reenable with C-z C-z in the prompt.
     (let ((ido-auto-merge-work-directories-length -1))
       (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                       (buffer-file-name))))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; Only rename if the file was saved before. Update the
  ;; buffer name and visited file in all cases.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil)))

  (setq default-directory (file-name-directory new-name))

  (message "Renamed to %s." new-name))

(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(defun my/kill-all-buffers-except-toolbox ()
  "Kill all buffers except current one and toolkit (*Messages*, *scratch*). Close other windows."
  (interactive)
  (switch-to-buffer "*scratch*")
  (mapc 'kill-buffer
        (remove-if
         (lambda (x)
           (or
            (eq x (current-buffer))
            (member (buffer-name x) '("*Messages*" "*scratch*"))))
         (buffer-list)))
  (delete-other-windows))

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))



;;; Keyboard
(global-set-key (kbd "C-x w") #'rename-file-and-buffer)
(global-set-key (kbd "C-x f") 'toggle-maximize-buffer)
(global-set-key (kbd "C-c k a") 'my/kill-all-buffers-except-toolbox)
(global-set-key (kbd "C-c k k") 'kill-buffer-and-window)
(global-set-key (kbd "C-c k f") 'delete-file-and-buffer)
(global-set-key (kbd "C-x C-b") #'bufler)
(global-set-key (kbd "C-x b") #'bufler-switch-buffer)
(global-set-key (kbd "M-o") #'ace-window)
(global-set-key (kbd "<C-tab>") #'next-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") #'previous-buffer)

(provide 'user-buffer)
