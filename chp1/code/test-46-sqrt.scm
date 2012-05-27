(load "test-manager/load.scm")
(load "46-sqrt.scm")

(define-each-check

    (>= 0.1
        (abs (- 3 (sqrt 9))))

)

(run-registered-tests)
