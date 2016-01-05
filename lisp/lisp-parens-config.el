;; smartparens
(require 'smartparens-config)
(sp-use-paredit-bindings)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
(sp-local-pair 'clojure-mode "`" "`")
(smartparens-global-mode)

;;; strict mode in lisps
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'lisp-mode-hook #'smartparens-strict-mode)

;; rainbow-delimiters
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)

(provide 'lisp-parens-config)
;;; lisp-parens-config.el ends here
