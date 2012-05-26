(load "test-manager/load.scm")
(load "11-iter.scm")

(define-each-check

    (= 1
       (f 1))

    (= 4
       (f 3))

    (= 11
       (f 4))

)

(run-registered-tests)
