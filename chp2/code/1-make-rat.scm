;;; 1-make-rat.scm

(define (make-rat n d)
    (if (< d 0)
        (cons (- n) (- d))
        (cons n d)))
