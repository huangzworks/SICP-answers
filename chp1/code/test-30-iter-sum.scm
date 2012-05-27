(load "test-manager/load.scm")
(load "30-iter-sum.scm")

(define-each-check

    (= 55
       (sum (lambda (x) x)
            1
            1+
            10))

)

(run-registered-tests)
