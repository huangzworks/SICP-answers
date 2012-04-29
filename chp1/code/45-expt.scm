;;; 45-expt.scm

(load "43-repeated.scm")

(define (expt base n)
    (if (= n 0)
        1
        ((repeated (lambda (x) (* base x)) n) 1)))
