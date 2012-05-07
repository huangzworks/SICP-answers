;;; 82-apply-generic.scm

(load "p119-attach-tag-and-type-tag-and-contents.scm")
(load "p133-coercion.scm")

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (let ((coercion-args (coercion-all args)))
                    (if coercion-args
                        (apply apply-generic (cons op coercion-args))
                        (error "No method for these types"
                                type-tags)))))))

(define (coercion-all args)
    ; 先尝试将所有参数都转换成第一个参数的类型
    ; 如果失败的话就尝试将所有参数都转成第二个参数的类型
    ; 以此类推，直到所有参数的类型都尝试完，或者转换成功为止
    (define (iter remaind-args)
        (if (null? remaind-args)
            #f
            (let ((current-arg-type (type-tag (car remaind-args))))
                (let ((coercion-args (coercion-to current-arg-type args)))
                    (if coercion-args
                        coercion-args
                        (iter (cdr remaind-args)))))))
    (iter args))

(define (coercion-to target-type args)
    ; 尝试将所有给定参数的类型全部转换为 target-type
    (if (not (all-coercion-proc-can-be-found? target-type (map type-tag args)))
        #f
        (map (lambda (arg)
                (let ((origin-type (type-tag arg)))
                    (if (equal? target-type origin-type)  ; 如果某个参数的类型已经是 target-type 
                        arg                               ; 那么不对这个参数做处理
                        (let ((orgin->target (get-coercion origin-type target-type)))
                            (orgin->target arg)))))
             args)))
                        
(define (all-coercion-proc-can-be-found? target-type arg-types)
    ; 检查是否所有其他参数都可以转换为 target-type
    ; 也即是，确认所需的强制过程是否全部都存在
    (every (lambda (result)
               (not (false? result)))
           (map (lambda (origin-type)
                    (get-coercion origin-type target-type))
                (remove (lambda (current-type)                  ; 不必检查 target-type 类型本身
                            (equal? current-type target-type))  ; 避免练习 2.81 的问题
                        arg-types))))
