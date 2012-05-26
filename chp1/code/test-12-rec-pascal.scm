(load "test-manager/load.scm")
(load "12-rec-pascal.scm")

(define-each-check

    (= 1
       (pascal 4 0))

    (= 1
       (pascal 4 4))

    (= 6
       (pascal 4 2))

)

(run-registered-tests)
