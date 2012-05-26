(load "test-manager/load.scm")
(load "9-dec.scm")

(define-each-check

    (= 3
       (dec 4))

    (= 4 
       (dec 5))

)

(run-registered-tests)
