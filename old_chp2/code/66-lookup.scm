;;; 66-lookup.scm

(define (lookup given-key tree-of-records)
    (if (null? tree-of-records)                                             ; 数据库为空，查找失败
        #f
        (let ((entry-key (key (entry tree-of-records))))                    ; 获取当前节点的键
            (cond ((= given-key entry-key)                                  ; 对比当前节点的键和给定的查找键
                    (entry tree-of-records))                                ; 决定查找的方向
                  ((> given-key entry-key)
                    (lookup given-key (right-branch tree-of-records)))
                  ((< given-key entry-key)
                    (lookup given-key (left-branch tree-of-records)))))))
