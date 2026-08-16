

(defvar host "aardmud.org")
(defvar port 4000)


(defun my-telnet-filter (process string)
  "Filter to handle ANSI colors, filter out ^M, and scroll the buffer."
  (let ((buffer (process-buffer process)))
    (when (buffer-live-p buffer)
      (with-current-buffer buffer
        ;; Allow modifying the buffer if it is read-only
        (let ((inhibit-read-only t)
              (moving (= (point) (point-max))))
          (save-excursion
            ;; Move to the end of the buffer to insert new text
            (goto-char (point-max))
            (let ((pmark (process-mark process)))
              (goto-char pmark)
              ;; 1. Filter out carriage returns (^M)
              (setq string (string-replace "\r" "" string))
              ;; 2. Insert the text
              (insert string)
              ;; 3. Decode ANSI color codes in the newly inserted text
              (ansi-color-apply-on-region pmark (point))
              ;; Update the process marker
              (set-marker pmark (point))))
          ;; 4. Scroll to the bottom if the point was already at the end
          (when moving
            (goto-char (point-max))
            (walk-windows
             (lambda (window)
               (when (eq (window-buffer window) buffer)
                 (set-window-point window (point-max))))
             nil t)))))))

(defun my-telnet-send-input ()
  "Send the current line of input to the telnet process."
  (interactive)
  (let ((proc (get-buffer-process (current-buffer))))
    (if (not proc)
        (error "No active process in this buffer")
      (let* ((pmark (process-mark proc))
             (input (buffer-substring-no-properties pmark (point-max))))
        ;; Insert a newline visually in the buffer
        (goto-char (point-max))
        (let ((inhibit-read-only t))
          (insert "\n"))
        ;; Send the input string with a newline to the process
        (process-send-string proc (concat input "\n"))
        ;; Advance the process marker past the input
        (set-marker pmark (point-max))))))

(defvar my-telnet-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET") 'my-telnet-send-input)
    map)
  "Keymap for my-telnet-mode.")

(define-minor-mode my-telnet-mode
  "Minor mode for interacting with a custom network stream."
  :init-value nil
  :keymap my-telnet-mode-map)

(defun my-start-telnet (host port)
  "Connect to HOST on PORT using open-network-stream."
  (interactive "sHost: \nnPort: ")
  (let* ((buf-name (format "*telnet-%s:%d*" host port))
         (buffer (get-buffer-create buf-name))
         (proc (open-network-stream "my-telnet-proc" buffer host port)))
    
    (with-current-buffer buffer
      (buffer-disable-undo)
      ;; Enable local minor mode for handling Return key
      (my-telnet-mode 1)
      ;; Initialize the process marker
      (set-marker (process-mark proc) (point-max)))
    
    ;; Assign the custom filter to the network process
    (set-process-filter proc 'my-telnet-filter)
    (switch-to-buffer buffer)))



(my-start-telnet host port)
