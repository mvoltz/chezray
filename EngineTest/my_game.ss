(define x 400)
(define y 225)

;; The engine will call this 60 times a second to update math
 (define (_update)
;; If btn 0 (Left) is true, move left!
  (if (btn 0) (set! x (- x 5)))
  ;; If btn 1 (Right) is true, move right!
  (if (btn 1) (set! x (+ x 5)))
  ;; If btn 2 (Up) is true, move up!
  (if (btn 2) (set! y (- y 5)))
  ;; If btn 3 (Down) is true, move down!
  (if (btn 3) (set! y (+ y 5))))


;; The engine will call this every frame to draw graphics
(define (_draw)
  (cls 1)              ;; Clear to dark blue
  (rect x y 50 50 8)) ;; Draw a moving red square
