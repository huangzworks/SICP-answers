(load "test-manager/load.scm")
(load "39-reverse-using-fold-left.scm")

(define-each-check

    (equal? (reverse '())
            '())

    (equal? (reverse (list 1 2 3))
            (list 3 2 1))

)

(run-registered-tests)
