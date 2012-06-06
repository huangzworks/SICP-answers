(load "test-manager/load.scm")
(load "60-intersection-set.scm")

(define-each-check

    (equal? (intersection-set '(1 2 3 1) '(1 2 3 1 4 5 6))
            '(1 2 3))

    (equal? (intersection-set '(1 2 3) '(1 2 3 4 5 6))
            '(1 2 3))

    (equal? (intersection-set '(1 2 3) '(4 5 6))
            '())

    (equal? (intersection-set '(1 2 3) '())
            '())

    (equal? (intersection-set '() '(1 2 3))
            '())

)

(run-registered-tests)
