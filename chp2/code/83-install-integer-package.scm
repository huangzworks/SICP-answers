;;; 83-install-integer-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-integer-package)

    (define (tag x)
        (attach-tag 'integer x))

    (put 'make 'integer
        (lambda (x)
            (tag (round (truncate x)))))  ; 截断小数点（如果有的话）

    ; 提升函数

    (define (integer->rational x)
        (make-rational x 1))

    (put 'raise '(integer) integer->rational)

'done)

(define (make-integer n)
    ((get 'make 'integer) n))
