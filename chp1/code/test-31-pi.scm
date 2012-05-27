(load "test-manager/load.scm")
(load "31-pi.scm")

(define-each-check

    (>= 0.01
        (abs (- 3.14
                (pi 10000))))

)

(run-registered-tests)
