(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(setq magit-last-seen-setup-instructions "1.4.0")
;; don't track local upstream branches by default; mimic git checkout -b
(setq magit-branch-arguments (remove "--track" magit-branch-arguments))
;; don't ask where to push branches with upstreams set
(setq magit-push-always-verify nil)
;; show lovely faces
(setq magit-revision-show-gravatars t)

(provide 'magit-config)
