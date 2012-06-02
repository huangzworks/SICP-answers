(load "test-manager/load.scm")
(load "46-sub-vect.scm")

(define diff (sub-vect (make-vect 0.5 0.5)
                       (make-vect 0.2 0.2)))

(define-each-check

    (= (xcor-vect diff)
       0.3)

    (= (ycor-vect diff)
       0.3)

)

(run-registered-tests)
