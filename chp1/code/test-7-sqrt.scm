(load "test-manager/load.scm")
(load "7-sqrt.scm")

(define-each-check

    (= 3
       (truncate (sqrt 9)))

)

(run-registered-tests)
