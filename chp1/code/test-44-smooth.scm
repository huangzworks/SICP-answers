(load "test-manager/load.scm")
(load "44-smooth.scm")

(define-each-check

    (>= 0.1
        (abs (- 25.0 ((smooth square) 5))))

)

(run-registered-tests)
