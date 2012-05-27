(load "test-manager/load.scm")
(load "33-product-of-coprimes.scm")

(define-each-check

    (= (product-of-coprimes 10)
       (* 1 3 7 9))

)

(run-registered-tests)
