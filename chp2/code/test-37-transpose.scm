(load "test-manager/load.scm")
(load "37-transpose.scm")

(define-each-check


    (equal? (transpose (list (list 1 2)
                             (list 3 4)))
            (list (list 1 3)
                  (list 2 4)))

)

(run-registered-tests)
