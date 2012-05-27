(load "test-manager/load.scm")
(load "45-expt.scm")

(define-each-check
    
    (= 1
       (expt 2 0))

    (= 2
       (expt 2 1))

    (= 128
       (expt 2 7))

    (= 1024
        (expt 2 10))

)

(run-registered-tests)
