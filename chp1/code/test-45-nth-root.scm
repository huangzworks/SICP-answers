(load "test-manager/load.scm")
(load "45-nth-root.scm")

(define sqrt (nth-root 2))

(define 6th-root (nth-root 6))

(define-each-check

    (>= 0.1
        (abs (- 3 (sqrt 9))))

    (>= 0.1
        (abs (- 3 (6th-root (* 3 3 3 3 3 3)))))

)

(run-registered-tests)
