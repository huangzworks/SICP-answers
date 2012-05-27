(load "test-manager/load.scm")
(load "31-iter-product.scm")

(define-each-check

    (= (* 1 2 3 4 5)
       (product (lambda (x) x)
                1
                1+
                5))

)

(run-registered-tests)
