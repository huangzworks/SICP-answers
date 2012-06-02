;;; 46-scale-vect.scm

(load "46-vect-represent.scm")

(define (scale-vect factor vect)
    (make-vect (* factor (xcor-vect vect))
               (* factor (ycor-vect vect))))
