(load "test-manager/load.scm")
(load "39-tan-cf.scm")

(define-each-check

    (= (tan 25)
       (tan-cf 25 100))

)

(run-registered-tests)
