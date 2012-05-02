;;; 59-union-set.scm

(load "p103-element-of-set.scm")

(define (union-set set1 set2)
    (define (iter set result)
        (cond ((null? set)
                (reverse result))
              ((element-of-set? (car set) result)
                (iter (cdr set) result))
              (else
                (iter (cdr set) (cons (car set) result)))))
    (iter (append set1 set2) '()))
