(load "test-manager/load.scm")
(load "38-e.scm")

(define-each-check

    (>= 0.1
        (abs (- 2.7 (e 100))))

)

(run-registered-tests)
