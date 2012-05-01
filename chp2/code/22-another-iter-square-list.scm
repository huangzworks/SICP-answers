;;; 22-another-iter-square-list.scm

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)  
                  (cons (square (car things))
                        answer))))
    (iter (reverse items) '()))  ; 修改
