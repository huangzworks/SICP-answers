;;; 7-make-interval.scm

(define (make-interval a b) (cons a b))

(define (upper-bound intrvl)
   (cdr intrvl))

(define (lower-bound intrvl)
   (car intrvl))
