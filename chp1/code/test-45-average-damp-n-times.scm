(load "test-manager/load.scm")
(load "45-average-damp-n-times.scm")

(define-each-check

    (>= 0.1
        (abs (- 10 ((average-damp-n-times square 100) 10.0))))

)

(run-registered-tests)
