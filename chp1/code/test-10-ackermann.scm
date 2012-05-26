(load "test-manager/load.scm")
(load "10-ackermann.scm")

(define-each-check

    (= 1024 
       (A 1 10))

    (= 65536
       (A 2 4))

)

(run-registered-tests)
