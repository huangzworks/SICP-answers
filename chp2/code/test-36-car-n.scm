(load "test-manager/load.scm")
(load "36-car-n.scm")

(define-each-check

    (equal? (car-n (list (list 1 2 3)
                         (list 4 5 6)
                         (list 7 8 9)))
            (list 1 4 7))

)

(run-registered-tests)
