;;; 29-new-selector.scm

(define (left-branch mobile)
    (car mobile))

(define (right-branch mobile)
    (cdr mobile))

(define (branch-length branch)
    (car branch))

(define (branch-structure branch)
    (cdr branch))
