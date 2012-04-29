;;; 46-sqrt.scm

(load "46-iterative-improve.scm")

(define (sqrt x)
    (define dx 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) dx))
    (define (improve guess)
        (average guess (/ x guess)))
    (define (average x y)
        (/ (+ x y) 2))
    ((iterative-improve close-enough? improve) 1.0))
