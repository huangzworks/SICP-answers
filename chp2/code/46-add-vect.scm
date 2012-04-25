;;; 46-add-vect.scm

(load "46-make-vect.scm")
(load "46-xcor-vect-and-ycor-vect.scm")

(define (add-vect vect another-vect)
    (make-vect (+ (xcor-vect vect)
                  (xcor-vect another-vect))
               (+ (ycor-vect vect)
                  (ycor-vect another-vect))))
