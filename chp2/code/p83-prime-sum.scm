;;; p83-prime-sum.scm

(load "p33-prime.scm")

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))
