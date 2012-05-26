(load "test-manager/load.scm")
(load "p33-divides.scm")

(define-each-check

    (divides? 2 4)

    (false? (divides? 2 3))

)

(run-registered-tests)
