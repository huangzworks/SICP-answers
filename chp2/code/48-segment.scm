;;; 48-segment.scm

(define (make-segment start end)
    (list start end))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cadr seg))
