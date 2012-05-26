(load "test-manager/load.scm")
(load "16-fast-expt.scm")

(define-each-check

    (= (expt 2 8)
       (fast-expt 2 8))

    (= (expt 3 5)
       (fast-expt 3 5))

)

(run-registered-tests)
