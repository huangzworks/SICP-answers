;;; 13-make-cycle.scm

(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)
