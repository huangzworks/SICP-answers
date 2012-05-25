;;; p15-improve.scm

(load "p15-average.scm")

(define (improve guess x)
    (average guess (/ x guess)))
