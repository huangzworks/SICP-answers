;;; 33-primes-sum.scm

(load "33-filtered-accumulate.scm")
(load "p33-prime.scm")

(define (primes-sum a b)
    (filtered-accumulate + 
                         0
                         (lambda (x) x)
                         a
                         (lambda (i) (+ i 1))
                         b
                         prime?))
