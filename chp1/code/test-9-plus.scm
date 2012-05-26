(load "test-manager/load.scm")
(load "9-plus.scm")

(define-each-check

    (= 3
       (plus 1 2))

    (= 10
       (plus 3 7))

)

(run-registered-tests)
