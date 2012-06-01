(load "test-manager/load.scm")
(load "42-adjoin-position.scm")

(define-each-check

    (equal? (adjoin-position 5 4 (list 8 2 4))
            (list 5 8 2 4))

    (equal? (adjoin-position 3 1 '())
            (list 3))

)

(run-registered-tests)
