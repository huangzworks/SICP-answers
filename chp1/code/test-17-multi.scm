(load "test-manager/load.scm")
(load "17-multi.scm")

(define-each-check

    (= (multi 3 3)
       (* 3 3))

    (= (multi 3 4)
       (* 3 4))

)

(run-registered-tests)
