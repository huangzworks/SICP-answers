(load "test-manager/load.scm")
(load "1-make-rat.scm")

(define-each-check

    (equal? (make-rat 1 2)
            (cons 1 2))

    (equal? (make-rat -1 -2)
            (cons 1 2))

    (equal? (make-rat -1 2)
            (cons -1 2))

    (equal? (make-rat 1 -2)
            (cons -1 2))
)

(run-registered-tests)
