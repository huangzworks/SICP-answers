;;; 48-serialized-exchange.scm

(load "p214-exchange.scm")

(define (serialized-exchange acc-1 acc-2)
    ; 获取并对比两个帐号的 id 值
    ; 然后传给 serialize-and-exchange
    (if (< (acc-1 'id) (acc-2 'id))
        (serialize-and-exchange acc-1 acc-2)
        (serialize-and-exchange acc-2 acc-1)))

(define (serialize-and-exchange smaller-id-account bigger-id-account)
    ; 使用两个 let 结构
    ; 按顺序先后获取两个帐号的 serializer
    (let ((smaller-serializer (smaller-id-account 'serializer)))
        (let ((bigger-serializer (bigger-id-account 'serializer)))
            ((smaller-serializer (bigger-serializer exchange))
             smaller-id-account
             bigger-id-account))))
