;;; user-buffer -- Buffer management

;;; Commentary:

;; Provides more buffer customization and corresponding file management

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
  :bind ((:map global-map ("M-o" . ace-window)))
  :custom
  (aw-ignore-current t)
  (aw-scope 'frame))

(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(defun kill-all-buffers-except-toolbox ()
  "Kill all buffers except current one and toolkit (*Messages*, *scratch*). Close other windows."
  (interactive)
  (switch-to-buffer "*scratch*")
  (mapc 'kill-buffer
        (cl-remove-if
         (lambda (x)
           (or
            (eq x (current-buffer))
            (member (buffer-name x) '("*Messages*" "*scratch*"))))
         (buffer-list)))
  (delete-other-windows))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

;; Frame title formatting.
(setq-default frame-title-format
              '((:eval (if (buffer-file-name)
                           (abbreviate-file-name (buffer-file-name))
                         "%b"))))

;; Overrides Emacs' default mechanism for making buffer names unique.
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*")) ; don't muck with special buffers

;;; Keyboard
(global-set-key (kbd "C-x f") #'toggle-maximize-buffer)
(global-set-key (kbd "C-c A") #'kill-all-buffers-except-toolbox)
(global-set-key (kbd "C-c K") #'kill-buffer-and-window)
(global-set-key (kbd "C-x C-b") #'bufler)
(global-set-key (kbd "C-x b") #'bufler-switch-buffer)
(global-set-key (kbd "<C-x o>") #'ace-window)
(global-set-key (kbd "<C-M-tab>") #'next-buffer)
(global-set-key (kbd "<C-M-S-iso-lefttab>") #'previous-buffer)
(global-set-key (kbd "C-x |") 'toggle-window-split)

(provide 'user-buffer)
