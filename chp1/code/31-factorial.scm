;;; 31-factorial.scm

(load "31-iter-product.scm")

(define (factorial n)
    (product (lambda (x) x)
             1
             (lambda (i) (+ i 1))
             n))
