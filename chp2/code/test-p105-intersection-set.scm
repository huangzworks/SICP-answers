(load "test-manager/load.scm")
(load "p105-intersection-set.scm")

(define-each-check

    (equal? (intersection-set '(1 3 5 7 9)
                              '(1 2 3 4 5))
            '(1 3 5))

    (equal? (intersection-set '(1 2 3)
                              '())
            '())

    (equal? (intersection-set '()
                              '(1 2 3))
            '())

)

(run-registered-tests)
