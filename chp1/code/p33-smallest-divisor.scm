;;; p33-smallest-divisor.scm

(load "p33-divides.scm")
(load "p33-find-divisor.scm")

(define (smallest-divisor n)
    (find-divisor n 2))
