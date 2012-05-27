(load "test-manager/load.scm")
(load "29-simpson.scm")
(load "8-cube.scm")

(define-each-check

    (>= 0.01
        (abs (- 0.25 (simpson cube 0 1 1000))))

)

(run-registered-tests)
