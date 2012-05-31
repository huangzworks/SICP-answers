;;; p68-length.scm

(define (length items)
    (if (null? items)
        0
        (+ 1 
           (length (cdr items)))))
