

;; 1. THE LEVEL DATA
(define tile-size 40) ;; Each tile will be 40x40 pixels

(define level-map
  '( (6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6)
     (6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6)
     (6 0 0 3 3 3 0 0 0 0 0 0 5 5 0 0 0 0 0 6)
     (6 0 0 0 3 0 0 0 0 0 0 5 5 5 5 0 0 0 0 6)
     (6 0 0 0 0 0 0 0 0 0 0 0 5 5 0 0 0 0 0 6)
     (6 0 0 0 0 0 0 6 6 6 6 0 0 0 0 0 0 0 0 6)
     (6 0 0 0 0 0 0 6 0 0 6 0 0 0 0 0 0 0 0 6)
     (6 0 0 0 0 0 0 6 0 0 6 0 0 0 0 0 0 0 0 6)
     (6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6)
     (6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6) ))


;; 2. THE MAP RENDERER
(define (draw-map)
  ;; Start at row 0 (y-index) and the first row list
  (let loop-y ([y-idx 0] [rows level-map])
    (if (not (null? rows))
        (begin
          ;; For every row, start at column 0 (x-index) and read the numbers
          (let loop-x ([x-idx 0] [cols (car rows)])
            (if (not (null? cols))
                (begin
                  (let ([tile-id (car cols)])
                    ;; If the tile isn't 0 (empty), draw it!
                    (if (> tile-id 0)
                        (rect (* x-idx tile-size)  ;; Screen X
                              (* y-idx tile-size)  ;; Screen Y
                              tile-size 
                              tile-size 
                              tile-id)))           ;; Color
                  
                  ;; Move to the next column
                  (loop-x (+ x-idx 1) (cdr cols)))))
          
          ;; Move to the next row
          (loop-y (+ y-idx 1) (cdr rows))))))

(define x 400)
(define y 225)

;; The engine will call this 60 times a second to update math
 (define (_update)
;; If btn 0 (Left) is true, move left!
(if (btn 0) (set! x (- x 15)))
;; If btn 1 (Right) is true, move right!
(if (btn 1) (set! x (+ x 15)))
;; If btn 2 (Up) is true, move up!
(if (btn 2) (set! y (- y 15)))
;; If btn 3 (Down) is true, move down!
(if (btn 3) (set! y (+ y 15))))


;; The engine will call this every frame to draw graphics
(define (_draw)
  (cls 1)              ;; Clear to dark blue
  (draw-map)
  (rect x y 20 20 8)) ;; Draw a moving red square
