;;; 35-count-leaves-using-recursion.scm

(load "p78-accumulate.scm")

(define (count-leaves tree)
    (accumulate +
                0
                (map (lambda (sub-tree)
                         (if (pair? sub-tree)           ; 如果这个节点有分支
                             (count-leaves sub-tree)    ; 那么这个节点调用 count-leaves 的结果就是这个节点的树叶数量
                             1))                        ; 遇上一个叶子节点就返回 1
                     tree)))
