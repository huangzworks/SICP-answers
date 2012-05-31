(load "test-manager/load.scm")
(load "p68-length.scm")

(define-each-check

    (= (length '())
       0)

    (= (length (list 1))
       1)

    (= (length (list 1 2 3))
       3)

)

(run-registered-tests)
