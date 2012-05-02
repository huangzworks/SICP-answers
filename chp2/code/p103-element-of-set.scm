;;; p103-element-of-set.scm

(define (element-of-set? x set)
    (cond ((null? set)
            #f)
          ((equal? x (car set))
            #t)
          (else
            (element-of-set? x (cdr set)))))
