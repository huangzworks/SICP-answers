(load "test-manager/load.scm")
(load "33-iter-filtered-accumulate.scm")

(define-each-check

    (= (+ 1 3 5 7 9)
       (filtered-accumulate + 
                            0
                            (lambda (x) x)
                            1
                            1+
                            10
                            odd?))

)

(run-registered-tests)
