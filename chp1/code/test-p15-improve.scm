(load "test-manager/load.scm")
(load "p15-improve.scm")

(define-each-check

    (= (improve 3 9)
       (average 3 (/ 9 3)))

)

(run-registered-tests)
