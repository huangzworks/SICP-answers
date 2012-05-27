(load "test-manager/load.scm")
(load "35-golden-ratio.scm")

(define-each-check

    (>= 0.1
        (abs (- 1.6 golden-ratio)))

)

(run-registered-tests)
