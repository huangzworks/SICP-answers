(load "test-manager/load.scm")
(load "23-find-divisor.scm")

(define-each-check

    (= 2 
       (find-divisor 10 2))

    (= 3
       (find-divisor 9 2))
   
    (= 7
       (find-divisor 7 2))

)

(run-registered-tests)
