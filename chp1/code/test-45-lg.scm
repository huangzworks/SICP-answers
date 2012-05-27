(load "test-manager/load.scm")
(load "45-lg.scm")

(define-each-check

    (= 0
       (lg 0))

    (= 0
       (lg 1))

    (= 1 
       (lg 2))

    (= 10
       (lg 1024))

)

(run-registered-tests)
