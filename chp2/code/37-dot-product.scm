;;; 37-dot-product.scm

(load "p78-accumulate.scm")

(define (dot-product v w)
    (accumulate +
                0
                (map * v w)))
