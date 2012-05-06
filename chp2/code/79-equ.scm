;;; 79-equ.scm

(load "p125-apply-generic.scm")

(define (equ? x y)
    (apply-generic 'equ? x y))
