;;; p16-sqrt.scm

(load "p15-sqrt-iter.scm")

(define (sqrt x)
    (sqrt-iter 1.0 x))
