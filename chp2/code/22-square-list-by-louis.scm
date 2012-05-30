;;; 22-square-list-by-louis.scm

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)  
                  (cons (square (car things))
                        answer))))
    (iter items '()))
