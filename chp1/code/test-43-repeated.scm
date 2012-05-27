(load "test-manager/load.scm")
(load "43-repeated.scm")

(define-each-check

    (= ((repeated square 2) 5)
       625)

)

(run-registered-tests)
