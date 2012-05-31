(load "test-manager/load.scm")
(load "p70-map.scm")

(define-each-check

    (equal? (map square (list 1 2 3))
            (list (square 1)
                  (square 2)
                  (square 3)))

)

(run-registered-tests)
