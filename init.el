;;; This was installed by package-install.el.
;;; This provides support for the package system and
;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(ecb-options-version "2.40")
 '(ido-case-fold t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(initial-major-mode (quote eshell-mode))
 '(ns-alternate-modifier nil)
 '(ns-right-alternate-modifier (quote meta))
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(visual-line-mode nil t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq auto-save-default nil)
(setq inhibit-startup-message t)

;;Haskell mode, requires haskell-hlint for compiling 
;; try C-ch for list of commands
(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(require 'inf-haskell)
(require 'flymake)

(defun flymake-haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "flycheck_haskell.pl"
	(list source base-dir)))

(push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\(.+\\)" 1 2 3 4) flymake-err-line-patterns)

(add-hook
     'haskell-mode-hook
     '(lambda ()
        (define-key haskell-mode-map "\C-ch"
          'credmp/flymake-display-err-minibuf)))


(setq load-path (cons  "/usr/lib/erlang/lib/tools-2.6.6.1/emacs" load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)
(require 'erlang-flymake)

(add-hook 'erlang-mode-hook 'my-erlang-hook-function)
(defun my-erlang-hook-function ()
  (imenu-add-to-menubar "Functions"))

;; This is needed for Distel setup
(let ((distel-dir "/usr/share/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))
(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-name" "emacs@127.0.0.1"))
	    ;; add Erlang functions to an imenu menu
	    (imenu-add-to-menubar "imenu")))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-'"      erl-complete)	
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind) 
    ("\M-+"      erl-find-source-unwind) 
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;; add some Distel bindings to the Erlang shell
	    (dolist (spec distel-shell-keys)
	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/fsharp")
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)


;; (require 'rfringe)
(require 'flymake-cursor)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")
(require 'color-theme)
(color-theme-initialize)
(color-theme-zenburn)

(require 'ido)
(require 'eshell)

(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "M-C-f") 'enlarge-window-horizontally)
(global-set-key (kbd "M-C-c") 'enlarge-window)

