;;; 31-tree-map-using-map.scm

(define (tree-map f tree)
    (map (lambda (sub-tree)
             (if (pair? sub-tree)
                 (tree-map f sub-tree)  ; 递归处理左右分支
                 (f sub-tree)))
         tree))
