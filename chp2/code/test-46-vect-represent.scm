(load "test-manager/load.scm")
(load "46-vect-represent.scm")

(define-each-check

    (= (xcor-vect (make-vect 0.5 1.0))
       0.5)
           
    (= (ycor-vect (make-vect 0.5 1.0))
       1.0)

)

(run-registered-tests)
