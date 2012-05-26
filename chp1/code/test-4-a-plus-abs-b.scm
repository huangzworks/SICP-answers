(load "test-manager/load.scm")
(load "4-a-plus-abs-b.scm")

(define-each-check

    (= 4
       (a-plus-abs-b 2 2))

    (= 4
       (a-plus-abs-b 2 (- 2)))

)

(run-registered-tests)
