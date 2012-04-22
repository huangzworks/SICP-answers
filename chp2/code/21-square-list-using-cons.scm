;;; 21-square-list-using-cons.scm

(define (square-list items)
    (if (null? items)
        '()
        (cons (square (car items))
              (square-list (cdr items)))))
