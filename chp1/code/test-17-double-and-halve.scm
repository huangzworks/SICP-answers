(load "test-manager/load.scm")
(load "17-double-and-halve.scm")

(define-test (test-double)
    
    (check (= 4 (double 2)))

    (check (= 10 (double 5)))

)

(define-test (test-halve)
    
    (check (= 2 (halve 4)))

    (check (= 5 (halve 10)))

)

(run-registered-tests)
