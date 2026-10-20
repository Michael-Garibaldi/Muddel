;; Simple Mud Connector
;; Right now it setup a connection with Emac's telnet.el script
;; it CAN diplay colors, HOWEVER, to do that  you must
;; EDIT YOUR CONFIGURATION FILE and add in:
;; (require 'ansi-color) for this to work.

;; Looks great in Vivendi


;; Setting up a toggle switch to set user injput from the main window to the echo window
;; It's a toggle switch, so clicking it changes the focus from the main window
;; to the echo window and back.



;; Stops the refresh after carriage return.

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-r)

;; Match telnet echoing with newlines
(setq telnet-new-line "\r\n")


;;test line
;;(setq process-connection-type t)

;; Define the buffer and give it a name.

(defvar my-telnet-input-target 'buffer
  "Tracks whether input is sent from 'buffer or 'minibuffer.")

;; Setting up the ability to switch from the minibuffer to the text buffer

(defun my-telnet-send-input (text)
  "Send TEXT to the active telnet process of the current buffer."
  (let ((proc (get-buffer-process (current-buffer))))
    (if proc
        (comint-send-string proc (concat text "\n"))
      (error "No active telnet process in this buffer"))))

(defun my-telnet-toggle-and-send ()
  "Prompt via minibuffer or grab from buffer, then send to telnet."
  (interactive)
  (let ((input (if (eq my-telnet-input-target 'minibuffer)
                   (read-string "> ")
                 (progn
                   (when (use-region-p)
                     (error "Clear or use region logic if desired"))
                   ;; Grab current line or prompt-to-end in buffer
                   (buffer-substring-no-properties (line-beginning-position)
                                                   (line-end-position))))))
    (my-telnet-send-input input)))

(defun my-telnet-switch-input-mode ()
  "Toggle input source between buffer text area and minibuffer."
  (interactive)
  (setq my-telnet-input-target
        (if (eq my-telnet-input-target 'buffer) 'minibuffer 'buffer))
  (message "Telnet input source switched to: %s" my-telnet-input-target))

;; Bind keys in telnet-mode-map
(define-key global-map (kbd "C-c c") 'my-telnet-toggle-and-send)
(define-key global-map (kbd "C-c t") 'my-telnet-switch-input-mode)


;; Setup mud name and port
;; Edit this to change your mud connection, edit inside the quotes only

(defvar my-telnet-host "aardmud.org")
(defvar my-telnet-port "4000")


;; Sets up the buffer to initiate a telnet session

(defun start-my-telnet-buffer ()
  (interactive)
  (let ((buffer (get-buffer-create "*my-telnet*")))
    (with-current-buffer buffer
      (comint-mode)
       (make-network-process :name "my-telnet"
                            :buffer buffer
                            :family 'ipv4
                            :host my-telnet-host
                            :service my-telnet-port
                            :filter 'my-telnet-filter)))
  (switch-to-buffer "*my-telnet*" ))

;; Here's where the Ansi color actually gets filtered out
;; The second "(save-excusion)" is to filter out the "^M" on screen

(defun my-telnet-filter (proc string)
  "Filter live stream, apply ANSI colors, and insert into buffer."
  (when (buffer-live-p (process-buffer proc))
   (with-current-buffer (process-buffer proc)
      (let ((moving (= (point) (process-mark proc))))
        (save-excursion
          (goto-char (process-mark proc))
          (insert (ansi-color-apply string))
          (set-marker (process-mark proc) (point)))
        (if moving (goto-char (process-mark proc))))
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "\r" nil t)
      (replace-match " "))))))


;; This causes the connection to start up once this is run
(start-my-telnet-buffer)


;; Keystroke definitions



;;; This MUST match the name of the script

(provide 'muddel)


