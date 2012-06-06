(load "test-manager/load.scm")
(load "62-union-set.scm")

(define-each-check

    (equal? (union-set '() '())
            '())

    (equal? (union-set '(1 2 3) '())
            '(1 2 3))

    (equal? (union-set '() '(1 2 3))
            '(1 2 3))

    (equal? (union-set '(1 3 5) '(1 2 3 4 5))
            '(1 2 3 4 5))

)

(run-registered-tests)
