;;; 31-tree-map-using-map.scm

(define (tree-map f tree)
    (map (lambda (sub-tree)
             (if (pair? sub-tree)
                 (tree-map f sub-tree)  ; 处理子树
                 (f sub-tree)))         ; 处理节点
         tree))
