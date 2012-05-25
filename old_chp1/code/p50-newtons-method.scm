;;; p50-newtons-method.scm

(load "p46-fixed-point.scm")
(load "p49-newton-transform.scm")

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))
