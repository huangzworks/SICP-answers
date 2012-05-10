;;; 13-make-crycle.scm

(define (make-crycle x)
    (set-cdr! (last-pair x) x)
    x)
