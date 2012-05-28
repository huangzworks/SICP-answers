;;; 27-better-deep-reverse.scm

(define (deep-reverse tree)
    (cond ((empty-tree? tree)
            '())
          ((leaf? tree)
            tree)
          (else
            (reverse (make-tree (deep-reverse (left-branch tree))
                                (deep-reverse (right-branch tree)))))))

(define (empty-tree? tree)
    (null? tree))

(define (leaf? tree)
    (not (pair? tree)))

(define (make-tree left-branch right-branch)
    (list left-branch right-branch))

(define (left-branch tree)
    (car tree))

(define (right-branch tree)
    (cadr tree))
