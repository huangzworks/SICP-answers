;;; 23-double-linked-list.scm

(define (make-double-linked-list)
    '())

(define (empty-double-linked-list? lst)
    (null? lst))

(define (insert-double-linked-list! lst item)
    (cond ((empty-double-linked-list?)
            (set! lst (make-node item '() '()))
            lst)
          (else
            
