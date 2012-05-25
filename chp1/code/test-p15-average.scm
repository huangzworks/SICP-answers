(load "test-manager/load.scm")
(load "p15-average.scm")

(define-each-check
    (= 3 (average 3 3))
    (= 4 (average 2 6))
)

(run-registered-tests)
