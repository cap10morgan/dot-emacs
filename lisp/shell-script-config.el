(defun wsm-set-sh-indents ()
  (setq sh-basic-offset 2
        sh-indentation 2
        sh-indent-after-else 2))
(add-hook 'sh-mode-hook 'wsm-set-sh-indents)

(provide 'shell-script-config)
