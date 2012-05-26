(load "test-manager/load.scm")
(load "28-non-zero-random.scm")

(define-each-check

    (< 0 (non-zero-random 10))

    (> 10 (non-zero-random 10))

)

(run-registered-tests)
