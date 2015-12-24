(setq inhibit-startup-screen t)

;; local lisp files & packages
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "~/.emacs.d/packages/")
(let ((default-directory "~/.emacs.d/packages/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'my-packages)

;; handy shortcuts
(defalias 'yes-or-no-p 'y-or-n-p)

;; get exec path & other env vars from shell
(require 'exec-path-from-shell)
(add-to-list 'exec-path-from-shell-variables "LEIN_JAVA_CMD")
(exec-path-from-shell-initialize)

(require 'emacs-appearance)

(require 'emacs-behavior)

(require 'ido-config)

(require 'my-smartparens-config)

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(require 'auto-save)

(require 'magit-config)

(require 'cider-config)

;; markdown
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

(require 'erlang-config)

(require 'shell-script-config)

(require 'idle-highlight-config)

;; projectile
(require 'projectile)
(projectile-global-mode)
(put 'downcase-region 'disabled nil)
