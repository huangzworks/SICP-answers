(load "test-manager/load.scm")
(load "17-last-pair.scm")

(define-each-check

    (equal? (last-pair (list 1))
            (list 1))

    (equal? (last-pair (list 1 2 3))
            (list 3))

)

(run-registered-tests)
