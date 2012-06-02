(load "test-manager/load.scm")
(load "46-scale-vect.scm")

(define product (scale-vect 2 
                            (make-vect 0.3 0.3)))

(define-each-check

    (= (xcor-vect product)
       0.6)

    (= (ycor-vect product)
       0.6)

)

(run-registered-tests)
