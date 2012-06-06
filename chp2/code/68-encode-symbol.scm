;;; 68-encode-symbol.scm

(load "p112-huffman.scm")

(define (encode-symbol symbol tree)
    (cond ((leaf? tree)                                         ; 如果已经到达叶子节点，那么停止积累
            '())
          ((symbol-in-tree? symbol (left-branch tree))          ; 符号在左分支(左子树)，组合起 0 
            (cons 0
                  (encode-symbol symbol (left-branch tree))))
          ((symbol-in-tree? symbol (right-branch tree))         ; 符号在右分支(右子树)，组合起 1
            (cons 1
                  (encode-symbol symbol (right-branch tree))))
          (else                                                 ; 给定符号不存在于树，报错
            (error "This symbol not in tree: " symbol))))

(define (symbol-in-tree? given-symbol tree)
    (not 
        (false?
            (find (lambda (s)                   ; 使用 find 函数，在树的所有符号中寻找给定符号
                      (eq? s given-symbol))
                  (symbols tree)))))            ; 取出树中的所有符号
