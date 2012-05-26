(load "test-manager/load.scm")
(load "9-inc.scm")

(define-each-check

    (= 3 
       (inc 2))

    (= 4
       (inc 3))

)

(run-registered-tests)
