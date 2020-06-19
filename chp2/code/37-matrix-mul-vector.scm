;;; 37-matrix-*-vector.scm

(load "37-dot-product.scm")

(define (matrix-*-vector m v)
    (map (lambda (col)
             (dot-product col v))
         m))
