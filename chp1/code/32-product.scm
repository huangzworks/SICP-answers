;;; 32-product.scm

(load "32-recursive-accumulate.scm")

(define (product term a next b)
    (accumulate *
                1 
                term
                a
                next
                b))
