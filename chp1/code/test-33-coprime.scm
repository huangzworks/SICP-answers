(load "test-manager/load.scm")
(load "33-coprime.scm")

(define-each-check

    (coprime? 3 7)

    (false? (coprime? 2 4))

)

(run-registered-tests)
