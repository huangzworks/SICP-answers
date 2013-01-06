;;; 27-tree-reverse.scm

(define (tree-reverse lst)
    (define (iter remained-items result)
        (if (null? remained-items)
            result
            (iter (cdr remained-items)
                  (cons (if (pair? (car remained-items))
                            (tree-reverse (car remained-items))
                            (car remained-items))
                        result))))
    (iter lst '()))
