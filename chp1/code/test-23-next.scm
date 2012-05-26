(load "test-manager/load.scm")
(load "23-next.scm")

(define-each-check

    (= 3
       (next 2))

    (= 5
       (next 3))

)

(run-registered-tests)
