(load "test-manager/load.scm")
(load "28-better-fringe.scm")

(define x (list (list 1 2) (list 3 4)))

(define-each-check

    (equal? (fringe '())
            '())

    (equal? (fringe x)
            (list 1 2 3 4))

    (equal? (fringe (list x x))
            (list 1 2 3 4 1 2 3 4))

)

(run-registered-tests)
