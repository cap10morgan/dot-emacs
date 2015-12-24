;; font
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 140
                    :weight 'normal
                    :width 'normal)

;; theme
(require 'solarized-theme)
(load-theme 'solarized-light t)

;; modeline
(column-number-mode t)
(setq sml/theme 'respectful)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^~/dev/" ":D:"))
;;(ocodo-svg-modelines-init)
;;(smt/set-theme 'ocodo-minimal-light-smt)

(provide 'emacs-appearance)
