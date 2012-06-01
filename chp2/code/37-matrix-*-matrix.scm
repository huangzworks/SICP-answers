;;; 37-matrix-*-matrix.scm

(load "37-transpose.scm")
(load "37-dot-product.scm")

(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (col-of-m)
                 (map (lambda (col-of-cols)
                          (dot-product col-of-m 
                                       col-of-cols))
                      cols))
             m)))
