(load "test-manager/load.scm")
(load "20-same-parity.scm")

(define-each-check

    (equal? (same-parity 1 2 3 4 5)
            (list 1 3 5))

    (equal? (same-parity 2 3 4 5 6)
            (list 2 4 6))

    (equal? (same-parity 2)
            (list 2))
)

(run-registered-tests)
