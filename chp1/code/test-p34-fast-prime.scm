(load "test-manager/load.scm")
(load "p34-fast-prime.scm")

(define-each-check

    (fast-prime? 7 10)

    (false? (fast-prime? 8 20))

)

(run-registered-tests)
