;;; 4-cons-and-car.scm

(define (cons x y)
    (lambda (m)
        (m x y)))

(define (car z)
    (z (lambda (p q) p)))
