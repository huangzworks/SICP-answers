(load "test-manager/load.scm")
(load "40-unique-pairs.scm")

(define-each-check

    (equal? (unique-pairs 4)
            (list (list 2 1)
                  (list 3 1)
                  (list 3 2)
                  (list 4 1)
                  (list 4 2)
                  (list 4 3)))

)

(run-registered-tests)
