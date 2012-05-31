(load "test-manager/load.scm")
(load "p78-enumerate-interval.scm")

(define-each-check

    (equal? (enumerate-interval 1 5)
            (list 1 2 3 4 5))

)

(run-registered-tests)
