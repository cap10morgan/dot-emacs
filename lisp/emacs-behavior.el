;; indentation
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq-default js-indent-level 2)

;; don't garbage collect so often
(setq gc-cons-threshold 20000000)

;; server
(require 'server)
(unless (server-running-p) (server-start))

;; global auto-revert-mode
(global-auto-revert-mode 1)

;; delete / overwrite region
(delete-selection-mode 1)

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'emacs-behavior)
