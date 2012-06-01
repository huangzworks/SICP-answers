(load "test-manager/load.scm")
(load "41-triple-sum-equal-to-using-fold.scm")

(define-each-check

    (triple-sum-equal-to? 6 (list 1 2 3))

    (false? (triple-sum-equal-to? 0 (list 1 2 3)))

)

(run-registered-tests)
