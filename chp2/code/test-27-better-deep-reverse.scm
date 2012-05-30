(load "test-manager/load.scm")
(load "27-better-deep-reverse.scm")

(define x (list (list 1 2) (list 3 4)))

(define-each-check

    (equal? (deep-reverse x)
            (list (list 4 3) (list 2 1)))

    (equal? (deep-reverse '())
            '())

)

(run-registered-tests)
