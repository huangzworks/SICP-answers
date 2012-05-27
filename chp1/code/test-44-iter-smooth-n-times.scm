(load "test-manager/load.scm")
(load "44-iter-smooth-n-times.scm")

(define-each-check

    (>= 0.1
        (abs (- 25.0 ((smooth-n-times square 10) 5))))

)

(run-registered-tests)
