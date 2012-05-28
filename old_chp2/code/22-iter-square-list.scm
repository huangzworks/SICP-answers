;;; 22-iter-square-list.scm

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            (reverse answer) ; 修改
            (iter (cdr things)  
                  (cons (square (car things))
                        answer))))
    (iter items '()))
