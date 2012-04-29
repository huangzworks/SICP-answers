;;; 46-fixed-point.scm

(load "46-iterative-improve.scm")

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (improve guess)
        (f guess))
    ((iterative-improve close-enough? improve) first-guess))
