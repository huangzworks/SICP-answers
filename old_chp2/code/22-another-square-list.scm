;;; 22-another-square-list.scm

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons answer
                        (square (car things))))))
    (iter items '()))
