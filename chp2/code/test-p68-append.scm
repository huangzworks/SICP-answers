(load "test-manager/load.scm")
(load "p68-append.scm")

(define-each-check

    (equal? (append (list 1 2 3) (list 4 5))
            (list 1 2 3 4 5))

    (equal? (append (list 1 2) '())
            (list 1 2))

)

(run-registered-tests)
