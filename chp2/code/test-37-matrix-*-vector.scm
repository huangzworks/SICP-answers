(load "test-manager/load.scm")
(load "37-matrix-*-vector.scm")

(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))

(define v (list 1 2 3 4))

(define-each-check
    
    (equal?  (matrix-*-vector m v)
             (list 30 56 80))

)

(run-registered-tests)
