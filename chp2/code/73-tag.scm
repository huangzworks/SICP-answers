;;; 73-tag.scm

(define (attach-tag type-tag x y)
    (list type-tag x y))

(define (type-tag datumn)
    (car datumn))

(define (contents datumn)
    (cdr datumn))
