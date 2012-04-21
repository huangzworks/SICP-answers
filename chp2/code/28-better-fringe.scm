;;; 28-better-fringe.scm

(define (fringe tree)
    (cond ((empty-tree? tree)
            '())
          ((leaf? tree)
            (list tree))
          (else
            (append (fringe (left-branch tree))
                    (fringe (right-branch tree))))))

(define (empty-tree? tree)
    (null? tree))

(define (leaf? tree)
    (not (pair? tree)))

(define (left-branch tree)
    (car tree))

(define (right-branch tree)
    (cadr tree))
