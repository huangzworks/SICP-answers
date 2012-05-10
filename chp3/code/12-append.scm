;;; 12-append.scm

(define (append! x y)
    (set-cdr! (last-pair x) y)
    x)
