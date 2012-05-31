(load "test-manager/load.scm")
(load "33-map.scm")

(define-each-check

    (equal? (map square '())
            '())

    (equal? (map square (list 1))
            (list (square 1)))

    (equal? (map square (list 1 2 3))
            (list (square 1) (square 2) (square 3)))


)

(run-registered-tests)
