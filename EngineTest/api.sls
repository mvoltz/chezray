
;; api.sls

(library (api)
  ;; 1. THE RESTRICTED EXPORTS (What the user is allowed to use)
  (export cls 
          rect
          btn
          sfx
          load-sfx)
  
  ;; 2. THE IMPORTS (What the engine needs to do the heavy lifting)
  (import (chezscheme)
          (raylib))

  ;; 3. THE ENGINE STATE (The 16-color palette)
  ;; We define a vector of 16 pre-calculated Raylib 32-bit colors.
  ;; 0 = Black, 1 = Dark Blue, ..., 8 = Red, etc.
  (define palette
    (vector (make-color 0 0 0 255)       ;; 0
            (make-color 29 43 83 255)    ;; 1
            (make-color 126 37 83 255)   ;; 2
            (make-color 0 135 81 255)    ;; 3
            (make-color 171 82 54 255)   ;; 4
            (make-color 95 87 79 255)    ;; 5
            (make-color 194 195 199 255) ;; 6
            (make-color 255 241 232 255) ;; 7
            (make-color 255 0 77 255)    ;; 8 (Red!)
            (make-color 255 163 0 255)   ;; 9
            (make-color 255 236 39 255)  ;; 10
            (make-color 0 228 54 255)    ;; 11
            (make-color 41 173 255 255)  ;; 12
            (make-color 131 118 156 255) ;; 13
            (make-color 255 119 168 255) ;; 14
            (make-color 255 204 170 255))) ;; 15
            
  ;; Helper to safely grab a color, defaulting to 0 (Black) if the user types a bad number
  (define (get-color c)
    (if (and (>= c 0) (<= c 15))
        (vector-ref palette c)
        (vector-ref palette 0)))

  ;; --- THE WRAPPER FUNCTIONS ---

  ;; CLS: Clear the screen
  ;; PICO-8 users type: (cls) or (cls 5)
  (define cls
    (case-lambda
      [()  (clear-background (get-color 0))]      ;; Default to black
      [(c) (clear-background (get-color c))]))    ;; Use specified color

  ;; RECT: Draw a filled rectangle
  ;; PICO-8 users type: (rect x y width height color-index)
  (define (rect x y w h c)
    (draw-rectangle x y w h (get-color c)))

  (define (btn i)
    (let ([check (lambda (keycode) (= (is-key-down? keycode) 1))])
    (cond
      [(= i 0) (check 263)]
      [(= i 1) (check 262)]
      [(= i 2) (check 265)]
      [(= i 3) (check 264)]
      [(= i 4) (check 90)]
      [(= i 5) (check 88)]
      [else #f])))

(define sfx-bank (make-vector 64 #f)) ;; 64 slots

(define (load-sfx id filename)
  (vector-set! sfx-bank id (load-sound filename)))

(define (sfx id)
  (let ([snd (vector-ref sfx-bank id)])
    (if snd
      (play-sound snd))))

)
