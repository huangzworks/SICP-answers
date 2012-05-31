(load "test-manager/load.scm")
(load "35-count-leaves-using-length.scm")

(define-each-check

    (= (count-leaves (list (list 1 2) (list 3 4)))
       4)

    (= (count-leaves (list (list 1 (list 2 3)) (list (list 4 5) (list 6 7))))
       7)

)

(run-registered-tests)
