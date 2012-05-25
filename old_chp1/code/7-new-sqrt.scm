;;; 7-new-sqrt.scm

(load "7-new-good-enough.scm")

(define (sqrt-iter guess x)
    (if (good-enough? guess (improve guess x))  ; 改动了这一行
        (improve guess x)
        (sqrt-iter (improve guess x)
                   x)))

;; 其他函数和原来的定义一样

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))
