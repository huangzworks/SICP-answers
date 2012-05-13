;;; 25-table.scm

(define (insert! key-list value table)
    (if (list? key-list)
        (let ((current-key (car key-list))
              (remain-key (cdr key-list)))
            (let ((record (assoc current-key (cdr table))))
                (cond 
                    ; 1) 有记录，且没有其他关键字
                    ;    更新记录的值
                    ((and record (null? remain-key))
                         (set-cdr! record value)
                         table)
                    ; 2) 有记录，且还有其他关键字
                    ;    说明这个记录实际上是一个子表
                    ;    使用 insert! 递归地进行插入操作
                    ((and record remain-key)
                        (insert! remain-key value record)
                        table)
                    ; 3) 无记录，且有其他关键字
                    ;    需要执行以下三步：
                    ;    一、 创建子表
                    ;    二、 对子表进行插入
                    ;    三、 将子表加入到 table
                    ;    这三个步骤可以用一句完成，wow！
                    ((and (not record) (not (null? remain-key)))
                        (join-in-table (insert! remain-key value (make-table current-key)) table)
                        table)
                    ; 4) 无记录，且无其他关键字
                    ;    创建记录并将它加入到 table
                    ((and (not record) (null? remain-key))
                        (let ((new-record (cons current-key value)))
                            (join-in-table new-record table)
                            table)))))
        (insert! (list key-list) value table)))  ; 将单个键转换成列表

(define (join-in-table new-record table)
    (set-cdr! table
              (cons new-record (cdr table))))

(define (lookup key-list table)
    (if (list? key-list)
        (let ((current-key (car key-list))
              (remain-key (cdr key-list)))
            (let ((record (assoc current-key (cdr table))))
                (if record
                    (if (null? remain-key)
                        (cdr record)
                        (lookup remain-key record))
                    #f)))
        (lookup (list key-list) table)))    ; 将单个键转换成列表

(define (make-table . table-name) 
    (if (null? table-name)
        (list '*table*)
        table-name))

; p 184
(define (assoc key records)
    (cond ((null? records)
            #f)
          ((equal? key (caar records))
            (car records))
          (else
            (assoc key (cdr records)))))


