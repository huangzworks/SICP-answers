(load "test-manager/load.scm")
(load "34-horner-eval.scm")

(define-each-check

    (= (horner-eval 2 (list 1 3 0 5 0 1))
       79)

)

(run-registered-tests)
