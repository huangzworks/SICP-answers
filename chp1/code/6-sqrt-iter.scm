;;; 6-sqrt-iter.scm

(load "6-new-if.scm")

(load "p15-good-enough.scm")                ; 定义平方根用到的其他函数
(load "p15-improve.scm")
(load "p16-sqrt.scm")

(define (sqrt-iter guess x)
    (new-if (good-enough? guess x)          ; <-- new-if 在这里
            guess
            (sqrt-iter (improve guess x)
                        x)))
