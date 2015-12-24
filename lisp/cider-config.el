(require 'cider)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq nrepl-log-messages t)
(setq cider-show-error-buffer nil)
(setq cider-stacktrace-fill-column t) ; t uses default fill-column
(setq cider-font-lock-dynamically '(macro core function var))
(setq cider-prompt-for-symbol nil) ; use symbol under point

;;; start a REPL with the test profile
(defun cider-jack-in-test-profile ()
  (interactive)
  (let ((cider-lein-parameters (concat "with-profile +test "
                                       cider-lein-parameters)))
    (cider-jack-in)))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map
     (kbd "C-c j") 'cider-jack-in-test-profile))

;;; auto-reload on save
;;; Taken from https://github.com/RallySoftware/rally-emacs/blob/master/rally/cider.el
(defun cider-auto-reload ()
  (when (and (member "cider-mode" (get-active-modes))
             (not (string/ends-with (buffer-name) "project.clj")))
    (cider-load-buffer)))

(defadvice save-buffer (after cider-reload-saved-file activate)
  (ignore-errors
    (cider-auto-reload)))

(provide 'cider-config)
