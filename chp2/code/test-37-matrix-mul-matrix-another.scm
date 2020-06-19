(load "test-manager/load.scm")
(load "37-transpose.scm")
(load "37-matrix-*-matrix-another.scm")

(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))

(define n (transpose m))

(define-each-check

    (equal? (matrix-*-matrix m n)
            (list (list 30 56 80)
                  (list 56 113 161)
                  (list 80 161 230)))

)

(run-registered-tests)
