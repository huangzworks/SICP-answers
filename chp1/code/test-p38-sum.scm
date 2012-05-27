(load "test-manager/load.scm")
(load "p38-sum.scm")

(define-each-check

    (= 55
       (sum (lambda (x) x)
            1
            1+
            10))

)

(run-registered-tests)
