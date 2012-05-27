;;; 32-sum.scm

(load "32-rec-accumulate.scm")

(define (sum term a next b)
    (accumulate + 
                0 
                term 
                a 
                next 
                b))
