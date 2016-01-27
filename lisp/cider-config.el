(require 'cider)
(require 'cider-scratch)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)
(setq nrepl-log-messages t)
(setq cider-show-error-buffer nil)
(setq cider-stacktrace-fill-column t) ; t uses default fill-column
(setq cider-font-lock-dynamically '(macro core function var))
(setq cider-prompt-for-symbol nil) ; use symbol under point

;; REPL history
(setq cider-repl-history-file "~/.emacs.d/cider-history")
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 3000)

;; REPL pretty printing
(setq cider-repl-use-pretty-printing t)
(setq cider-repl-use-clojure-font-lock t)

;; start a REPL with the test profile
(defun cider-jack-in-test-profile ()
  (interactive)
  (let ((cider-lein-parameters (concat "with-profile +test "
                                       cider-lein-parameters)))
    (cider-jack-in)))

(eval-after-load 'clojure-mode
  '(define-key clojure-mode-map
     (kbd "C-c j") 'cider-jack-in-test-profile))

;;; auto-reload in REPL on save
;;; Taken from https://github.com/RallySoftware/rally-emacs/blob/master/rally/cider.el
;;; This is currently unusable. Moves the point to the error constantly.
;; (defun get-active-modes ()
;;   (let ((active-modes))
;;     (mapc (lambda (mode) (condition-case nil
;;                              (if (and (symbolp mode) (symbol-value mode))
;;                                  (add-to-list 'active-modes (prin1-to-string mode)))
;;                            (error nil)))
;;           minor-mode-list)
;;     active-modes))

;; (defun string/ends-with (s ending)
;;   "return non-nil if string S ends with ENDING."
;;   (let ((elength (length ending)))
;;     (and (>= (length s) elength)
;;          (string= (substring s (- 0 elength)) ending))))

;; (defun cider-auto-reload ()
;;   (when (and (member "cider-mode" (get-active-modes))
;;              (not (string/ends-with (buffer-name) "project.clj")))
;;     (cider-load-buffer)))

;; (defadvice save-buffer (after cider-reload-saved-file activate)
;;  (ignore-errors
;;    (cider-auto-reload)))

(provide 'cider-config)
