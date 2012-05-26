;;; 8-cube-root.scm

(load "8-cube.scm")

(define (cube-root x)
    (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)            ; 和 sqrt-iter 是一样的
    (if (good-enough? guess x)              ; 改个名字，方便区别
        guess
        (cube-root-iter (improve guess x)
                        x)))

(define (good-enough? guess x)              ; 要用 cube 来检测是否足够好
    (< (abs (- (cube guess) x))
       0.001))

(define (improve guess x)                   ; 题目给出的公式
    (/ (+ (/ x (square guess)) (* 2 guess))
       3))
