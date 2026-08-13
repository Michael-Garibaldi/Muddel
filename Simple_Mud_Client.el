;; This buffer is for text that is not saved, an d for Lisp evaluation.
;; To create a file, visit it with ‘C-x C-f’ and enter text in its buffer.

;; setup the connection , mud name and port

;; Automatically colorize standard Emacs compilation buffers



;; Setup mud name and port


(defvar my-telnet-host "aardmud.org")
(defvar my-telnet-port "4000")

 
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
                            :filter 'my-telnet-filter))))
  ;(pop-to-buffer buffer))

(defun my-telnet-filter (proc string)
  "Filter live stream, apply ANSI colors, and insert into buffer."
  (when (buffer-live-p (process-buffer proc))
   (with-current-buffer (process-buffer proc)
      (let ((moving (= (point) (process-mark proc))))
        (save-excursion
          (goto-char (process-mark proc))
          (insert (ansi-color-apply string))
          (set-marker (process-mark proc) (point)))
        (if moving (goto-char (process-mark proc)))))))

(start-my-telnet-buffer)

(provide 'Simple_Mud_Client)
