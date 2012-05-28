;;; 80-zero.scm

(load "p125-apply-generic.scm")

(define (=zero? x)
    (apply-generic '=zero? x))
