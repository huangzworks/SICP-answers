(load "test-manager/load.scm")
(load "9-another-plus.scm")

(define-each-check

    (= 3
       (plus 1 2))

    (= 4
       (plus 2 2))

)

(run-registered-tests)
