(load "test-manager/load.scm")
(load "p83-make-pair-sum.scm")

(define-each-check

    (equal? (make-pair-sum (list 1 2))
            (list 1 2 3))

)

(run-registered-tests)
