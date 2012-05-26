(load "test-manager/load.scm")
(load "8-cube.scm")

(define-each-check

    (= (* 3 3 3)
       (cube 3))

    (= (* 8 8 8)
       (cube 8))

)

(run-registered-tests)
