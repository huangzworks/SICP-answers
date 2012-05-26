(load "test-manager/load.scm")
(load "28-miller-rabin-test.scm")

(define-each-check

    (Miller-Rabin-test 7)

    (false? (Miller-Rabin-test 561))

    (false? (Miller-Rabin-test 1729))

    (false? (Miller-Rabin-test 6601))

)

(run-registered-tests)
