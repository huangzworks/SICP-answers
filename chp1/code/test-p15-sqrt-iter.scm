(load "test-manager/load.scm")
(load "p15-sqrt-iter.scm")

(define-each-check
    
    (= 3 
       (truncate (sqrt-iter 1.0 9)))

    (= 4 
       (truncate (sqrt-iter 1.0 16)))

)

(run-registered-tests)
