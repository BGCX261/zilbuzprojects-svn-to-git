(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(delete-selection-mode t)
 '(ispell-check-comments t)
 '(show-paren-mode t))

(global-set-key [(delete)] 'delete-char)
(global-set-key [(control backspace)] 'backward-kill-word)
(global-set-key [(meta backspace)] 'backward-kill-word)
(global-set-key [(meta delete)] 'kill-word)
(global-set-key [(meta home)] 'backward-sentence)
(global-set-key [(meta end)] 'forward-sentence)
(global-set-key [(control c) (\;)] 'comment-region)

(setq load-path (cons "~/.emacs.d/tuareg/" load-path))
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(require 'font-lock)
(add-hook 'tuareg-mode-hook '(lambda ()
			       (flyspell-prog-mode)
			       (setq ispell-local-dictionary "fr_FR-80")
			       ))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 82 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono")))))
