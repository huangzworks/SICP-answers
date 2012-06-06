(load "test-manager/load.scm")
(load "61-another-adjoin-set.scm")

(define-each-check

    (equal? (adjoin-set 1 '())
            '(1))

    (equal? (adjoin-set 3 '(1 2 3 4))
            '(1 2 3 4))

    (equal? (adjoin-set 3 '(1 2 4))
            '(1 2 3 4))

)

(run-registered-tests)
