;;; 31-pi.scm

(load "31-iter-product.scm")
(load "31-numer-term.scm")
(load "31-denom-term.scm")

(define (pi n)
    (* 4
        (exact->inexact
            (/ (product numer-term
                        1
                        (lambda (i) (+ i 1))
                        n)
               (product denom-term 
                        1
                        (lambda (i) (+ i 1))
                        n)))))
