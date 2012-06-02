(load "test-manager/load.scm")
(load "46-add-vect.scm")

(define sum (add-vect (make-vect 0.5 0.5)
                      (make-vect 0.2 0.2)))

(define-each-check

    (= (xcor-vect sum)
       0.7)

    (= (ycor-vect sum)
       0.7)

)

(run-registered-tests)
