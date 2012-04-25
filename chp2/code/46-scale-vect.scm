;;; 46-scale-vect.scm

(load "46-make-vect.scm")
(load "46-xcor-vect-and-ycor-vect.scm")

(define (scale-vect factor vect)
    (make-vect (* factor (xcor-vect vect))
               (* factor (ycor-vect vect))))
