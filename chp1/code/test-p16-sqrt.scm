(load "test-manager/load.scm")
(load "p16-sqrt.scm")

(define-each-check

    (= 3
       (truncate (sqrt 9)))

    (= 5
       (truncate (sqrt 25)))

)

(run-registered-tests)
