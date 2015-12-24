(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

(defvar all-packages '(better-defaults smartparens idle-highlight-mode ido-ubiquitous
                                       find-file-in-project magit smex scpaste
                                       solarized-theme company rainbow-delimiters
                                       clojure-mode clojure-mode-extra-font-locking
                                       ;; cider
                                       exec-path-from-shell systemd
                                       yaml-mode markdown-mode dockerfile-mode web-mode
                                       coffee-mode smart-mode-line json-mode fish-mode
                                       scss-mode flx-ido projectile editorconfig))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (pkg all-packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

(provide 'my-packages)
