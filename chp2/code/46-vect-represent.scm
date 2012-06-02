;;; 46-vect-represent.scm

(define (make-vect xcor ycor)
    (list xcor ycor))

(define (xcor-vect v)
    (car v))

(define (ycor-vect v)
    (cadr v))
