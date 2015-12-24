(require 'smartparens-config)
(sp-use-paredit-bindings)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)
(smartparens-global-mode)
;; strict mode in lisps
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(sp-local-pair 'clojure-mode "`" "`")
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

(provide 'my-smartparens-config)
