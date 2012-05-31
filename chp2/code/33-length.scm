;;; 33-length.scm

(load "p78-accumulate.scm")

(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y))
                0
                sequence))
