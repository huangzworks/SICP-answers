(load "test-manager/load.scm")
(load "6-new-if.scm")

(define-each-check

    (= 1
       (new-if #t 1 2))

    (= 2
       (new-if #f 1 2))

)

(run-registered-tests)
