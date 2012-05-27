(load "test-manager/load.scm")
(load "31-denom-term.scm")

(define-each-check

    (= 3
       (denom-term 1))

    (= 3
       (denom-term 2))

    (= 5
       (denom-term 3))

)

(run-registered-tests)
