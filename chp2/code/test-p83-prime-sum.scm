(load "test-manager/load.scm")
(load "p83-prime-sum.scm")

(define-each-check

    (prime-sum? (list 1 2))

    (false? (prime-sum? (list 2 2)))

)

(run-registered-tests)
