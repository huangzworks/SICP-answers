;;; 60-intersection-set.scm

(load "p103-element-of-set.scm")

(define (intersection-set set another)
    (define (iter set result)
        (cond ((or (null? set) (null? another))
                (reverse result))
              ((and (element-of-set? (car set) another)         ; 只有不存在于 result 的交集元素
                    (not (element-of-set? (car set) result)))   ; 才会被加入进 result
                (iter (cdr set)
                      (cons (car set) result)))
              (else
                (iter (cdr set) result))))
    (iter set '()))
