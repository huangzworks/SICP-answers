;;; 30-square-tree-using-cond.scm

(define (square-tree tree)
    (cond ((null? tree)                         ; 空树
            '())
          ((not (pair? tree))                   ; 叶子节点
            (square tree))
          (else 
            (cons (square-tree (car tree))
                  (square-tree (cdr tree))))))
