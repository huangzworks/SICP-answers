;;; 37-matrix-*-matrix-another.scm

(load "37-transpose.scm")
(load "37-matrix-*-vector.scm")

(define (matrix-*-matrix m n)
    (let ((trans-n (transpose n)))
        (map (lambda (col-of-m)
                (matrix-*-vector trans-n col-of-m))
                m)))
