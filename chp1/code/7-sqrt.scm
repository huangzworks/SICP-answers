;;; 7-sqrt.scm

(load "p16-sqrt.scm")       ; 一定要先载入这些函数
(load "p15-improve.scm")    ; 确保后面定义的重名函数可以覆盖它们
(load "p15-average.scm")

(load "7-good-enough.scm")  ; 载入新的 good-enough?

(define (sqrt-iter guess x)
    (if (good-enough? guess (improve guess x))  ; 调用新的 good-enough?
        (improve guess x)
        (sqrt-iter (improve guess x)
                   x)))
