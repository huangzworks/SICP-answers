(load "test-manager/load.scm")
(load "8-cube-root.scm")

(define-each-check

    (= 3
       (truncate (cube-root (* 3 3 3))))

    (= 4
       (truncate (cube-root (* 4 4 4))))

)

(run-registered-tests)
