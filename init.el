(setq inhibit-startup-screen t)

;; local lisp files & packages
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "~/.emacs.d/packages/")
(let ((default-directory "~/.emacs.d/packages/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'my-packages)

;; handy shortcuts & keybindings
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-M-\\") 'just-one-space) ; I like Spotlight on cmd-spc

;; get exec path & other env vars from shell
(require 'exec-path-from-shell)
(add-to-list 'exec-path-from-shell-variables "LEIN_JAVA_CMD")
(exec-path-from-shell-initialize)

(require 'emacs-appearance)

(require 'emacs-behavior)

(require 'ido-config)

(require 'lisp-parens-config)

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(require 'auto-save)

(require 'magit-config)

;; clojure
(require 'cider-config)
;(require 'clj-refactor-config) ; try again when 2.0.0 comes out

;;(require 'flycheck-config) ; not working w/ CIDER 0.10.0

;; markdown

(require 'markdowner-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdowner-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdowner-mode))

(require 'erlang-config)

(require 'shell-script-config)

(require 'idle-highlight-config)

;; projectile
(require 'projectile)
(projectile-global-mode)
(put 'downcase-region 'disabled nil)

;; customizations
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
