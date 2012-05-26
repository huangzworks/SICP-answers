(load "test-manager/load.scm")
(load "p22-iter-factorial.scm")

(define-each-check

    (= 1
       (factorial 1))

    (= (* 1 2 3 4)
       (factorial 4))

)

(run-registered-tests)
