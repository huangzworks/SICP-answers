;;; 7-good-enough.scm

(define (good-enough? old-guess new-guess x)
    (< (abs (- (/ (* old-guess new-guess)
                  x)
               1)
       )
       0.001
    )
)
