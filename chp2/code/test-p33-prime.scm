(load "test-manager/load.scm")
(load "p33-prime.scm")

(define-each-check

    (prime? 7)

    (false? (prime? 10))

)

(run-registered-tests)
