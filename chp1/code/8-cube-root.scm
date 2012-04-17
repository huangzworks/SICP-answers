;;; 8-cube-root.scm

;; 求立方

(define (cube x)                                ; + 新增加或被修改过的代码都用 + 号标示
    (* x (square x)))                           ; +

;; 求次方根

(define (cube-root x)                           ; +
    (cube-root-iter 1.0 x))                     ; +

(define (cube-root-iter guess x)                ; +
    (if (good-enough? guess x)
        guess
        (cube-root-iter (improve guess x)       ; +
                        x)))

(define (good-enough? guess x)
    (< (abs (- (cube guess) x)) 0.001))

(define (improve guess x)                       ; +
    (/ (+ (/ x (square guess)) (* 2 guess))     ; +
       3))                                      ; +
