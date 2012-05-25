;;; 6.scm

;; new-if 以及使用 new-if 重写的 sqrt-iter 函数

(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(define (sqrt-iter guess x)
    (new-if (good-enough? guess x)  ; <-- new-if 在这里
            guess
            (sqrt-iter (improve guess x)
                        x)))

;; 其他函数，摘抄自书本 15 页

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))
