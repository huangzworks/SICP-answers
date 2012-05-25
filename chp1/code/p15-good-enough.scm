;;; p15-good-enough.scm

(define (good-enough? guess x)
    (< (abs (- (square guess) x))
       0.001))
