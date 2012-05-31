(load "test-manager/load.scm")
(load "p33-smallest-divisor.scm")

(define-each-check

    (= (smallest-divisor 7)
       7)

    (= (smallest-divisor 10)
       2)

)

(run-registered-tests)
