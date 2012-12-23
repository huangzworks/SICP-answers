(load "test-manager/load.scm")
(load "7-good-enough.scm")

(define-each-check

    (false? (good-enough? 1 3))

    (good-enough? 1 1)

)

(run-registered-tests)
