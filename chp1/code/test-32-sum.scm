(load "test-manager/load.scm")
(load "32-sum.scm")

(define-each-check

    (= (+ 1 2 3 4 5)
       (sum (lambda (x) x)
            1
            (lambda (i) (+ i 1))
            5))

)

(run-registered-tests)
