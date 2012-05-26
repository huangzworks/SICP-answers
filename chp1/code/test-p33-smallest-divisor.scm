(load "test-manager/load.scm")
(load "p33-smallest-divisor.scm")

(define-each-check

    (= 7
       (smallest-divisor 7))

    (= 2
       (smallest-divisor 10))

    (= 5
       (smallest-divisor 25))

)

(run-registered-tests)
