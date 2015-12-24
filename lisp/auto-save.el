(eval-when-compile (require 'cl-lib))
(defun save-buffers-if-visiting-file ()
  "Saves any buffers that are visiting a file."
  (interactive)
  (cl-letf (((symbol-function 'message) #'format))
    (save-some-buffers t)))

(add-hook 'auto-save-hook 'save-buffers-if-visiting-file)
(add-hook 'focus-out-hook 'save-buffers-if-visiting-file)
(add-hook 'mouse-leave-buffer-hook
          (lambda () (when buffer-file-name (save-buffer))))
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

(provide 'auto-save)
