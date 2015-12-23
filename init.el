(setq inhibit-startup-screen t)

;; local lisp files & packages
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/packages/"))
  (normal-top-level-add-subdirs-to-load-path))

;; packages
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

(defvar my-packages '(better-defaults smartparens idle-highlight-mode ido-ubiquitous
                                      find-file-in-project magit smex scpaste
                                      solarized-theme company rainbow-delimiters
                                      clojure-mode clojure-mode-extra-font-locking
                                      ;; cider - while I'm running a test version locally
                                      exec-path-from-shell systemd
                                      yaml-mode markdown-mode dockerfile-mode web-mode
                                      coffee-mode smart-mode-line json-mode fish-mode
                                      scss-mode flx-ido projectile editorconfig))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (pkg my-packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;; handy shortcuts
(defalias 'yes-or-no-p 'y-or-n-p)

;; get exec path & other env vars from shell
(require 'exec-path-from-shell)
(add-to-list 'exec-path-from-shell-variables "LEIN_JAVA_CMD")
(exec-path-from-shell-initialize)

;; indentation
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq-default js-indent-level 2)

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
;(ocodo-svg-modelines-init)
;(smt/set-theme 'ocodo-minimal-light-smt)

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

;; ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
;;(setq ido-use-faces nil) ; to see flx highlights, which I don't really like

;; smartparens
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

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; auto-save
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

;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(setq magit-last-seen-setup-instructions "1.4.0")
;; don't track local upstream branches by default; mimic git checkout -b
(setq magit-branch-arguments (remove "--track" magit-branch-arguments))
;; don't ask where to push branches with upstreams set
(setq magit-push-always-verify nil)
;; show lovely faces
(setq magit-revision-show-gravatars t)

;; cider
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

;; markdown
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

;; erlang
(setq erlang-root-dir "/usr/local/lib/erlang")
(defun load-erlang-from-homebrew ()
  (when (file-accessible-directory-p erlang-root-dir)
    (message "erlang-root-dir is accessible")
    (let* ((erlang-lib-dir (concat erlang-root-dir "/lib"))
           (default-directory erlang-lib-dir)
           (tools-dir (car (file-expand-wildcards "tools-*"))))
      (message "tools-dir: %S" tools-dir)
      (setq load-path (cons (concat erlang-lib-dir "/" tools-dir "/emacs") load-path))
      (message "load-path: %S" load-path)
      (setq exec-path (cons (concat erlang-root-dir "/bin") exec-path))
      (require 'erlang-start))))
(load-erlang-from-homebrew)

;; shell scripts
(defun wsm-set-sh-indents ()
  (setq sh-basic-offset 2
        sh-indentation 2
        sh-indent-after-else 2))
(add-hook 'sh-mode-hook 'wsm-set-sh-indents)

;; idle highlight
(add-hook 'clojure-mode-hook 'idle-highlight-mode)
(add-hook 'emacs-lisp-mode-hook 'idle-highlight-mode)
(add-hook 'ruby-mode-hook 'idle-highlight-mode)
(add-hook 'coffee-mode-hook 'idle-highlight-mode)
(add-hook 'yaml-mode-hook 'idle-highlight-mode)
(add-hook 'web-mode-hook 'idle-highlight-mode)

;; projectile
(require 'projectile)
(projectile-global-mode)
(put 'downcase-region 'disabled nil)
