(load "test-manager/load.scm")
(load "45-damped-nth-root.scm")

(define sqrt (damped-nth-root 2 1))

(define-each-check

    (>= 0.1
        (abs (- 3.0 (sqrt 9))))

)

(run-registered-tests)
