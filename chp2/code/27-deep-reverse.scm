;;; 27-deep-reverse.scm

(define (deep-reverse tree)
    (cond ((null? tree)         ; 空树
            '())
          ((not (pair? tree))   ; 叶子
            tree)
          (else
            (reverse (list (deep-reverse (car tree))            ; 递归地逆序左右子树
                           (deep-reverse (cadr tree)))))))
