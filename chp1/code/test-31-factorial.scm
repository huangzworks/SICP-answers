(load "test-manager/load.scm")
(load "31-factorial.scm")

(define-each-check

    (= (* 1 2 3 4 5)
       (factorial 5))

)

(run-registered-tests)
