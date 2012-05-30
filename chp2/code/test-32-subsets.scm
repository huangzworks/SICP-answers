(load "test-manager/load.scm")
(load "32-subsets.scm")

(define-each-check

    (equal? (subsets (list 1 2 3))
            (list (list) (list 3) (list 2) (list 2 3) (list 1) (list 1 3) (list 1 2) (list 1 2 3)))

)

(run-registered-tests)
