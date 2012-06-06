(load "test-manager/load.scm")
(load "59-union-set.scm")

(define-each-check

    (equal? (union-set '(1 2 3) '(3 4 5 6))
            '(1 2 3 4 5 6))

    (equal? (union-set '(1 2 3) '())
            '(1 2 3))

    (equal? (union-set '() '(1 2 3))
            '(1 2 3))

)

(run-registered-tests)
