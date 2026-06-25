(import (chezscheme)
        (raylib))

(define base-env (environment '(chezscheme) '(api)))  ;; these libraries are locked
(define sandbox-env (copy-environment base-env #t))   ;; this is a mutable copy for defining new vars

(define (safe-eval code)
  (guard (ex
           [else
             ;; If the user's code crashes, print the exact error to the terminal
             (display "GAME CRASH DETECTED: ")
             (display-condition ex)
             (newline)
             
             ;; We return a harmless dummy value so the engine loop doesn't break
             #f])
    
    ;; The dangerous part: evaluating the user's code
    (eval code sandbox-env)))

(define (load-cartridge filename)
  (guard (ex
            [else 
              (display "HOT-RELOAD FAILED: Syntax Error in File!\n")
              (display-condition ex)
              (newline)])
     (let ([port (open-input-file filename)])
       (let loop ([expr (read port)])
         (if (eof-object? expr)
             (begin
               (close-input-port port)
               (display "Cartridge Loaded Successfully!\n"))
             (begin
               ;; We use standard eval here, but it's protected by the guard above!
               (eval expr sandbox-env)
               (loop (read port)))))))) 
 
;;  (let ([port (open-input-file filename)])
;;    (let loop ([expr (read port)])
;;      (if (eof-object? expr)            ;; if end of file
;;          (close-input-port port)       ;; close file and finish
;;          (begin
;;            (eval expr sandbox-env)     ;; else execute code in sandbox
;;            (loop (read port)))))))     ;; loop to next line

(init-window 800 450 "Chezray Console")
(set-target-fps 60)

(load-cartridge "my_game.ss")

(let master-loop ()
  (if (window-should-close?)
      (close-window)
      (begin
        (if (= (is-key-pressed? 294) 1)
            (load-cartridge "my_game.ss"))
        
        (safe-eval '(_update))
        (begin-drawing)
        (safe-eval '(_draw))
       
        (end-drawing)
        (master-loop))))
