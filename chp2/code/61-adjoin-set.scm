;;; 61-adjoin-set.scm

(define (adjoin-set x set)
    (cond ((null? set)                          ; 空集，或者已到集合的末尾
            (list x))
          ((= x (car set))                      ; 元素已存在于集合
            set)
          ((> x (car set))                      ; 元素比当前集合元素大，继续向后移动指针
            (cons (car set)
                  (adjoin-set x (cdr set))))
          ((< x (car set))                      ; 元素比当前集合元素小
            (cons x set))))                     ; 使用 cons 将元素和剩余的集合元素组合起来
