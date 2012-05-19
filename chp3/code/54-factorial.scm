;;; 54-factorial.scm

(load "p228-integers.scm")
(load "54-mul-streams.scm")

(define factorial
    (cons-stream 1 
                 (mul-streams factorial
                              (stream-cdr integers))))  ; 因为 1 放在了定义前面，所以要从 stream-cdr 部分，也即是 2 开始给出整数序列流
