(load "test-manager/load.scm")
(load "p33-find-divisor.scm")

(define-each-check

    (= 2 (find-divisor 4 2))

    (= 2 (find-divisor 6 2))

    (= 7 (find-divisor 7 2))

)

(run-registered-tests)
