(load "test-manager/load.scm")
(load "43-iter-repeated.scm")

(define-each-check

    (= ((repeated square 2) 5)
       625)

)

(run-registered-tests)
