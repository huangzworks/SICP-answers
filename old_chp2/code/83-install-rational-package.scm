;;; 83-install-rational-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-rational-package)
    
    (define (tag x)
        (attach-tag 'rational x))

    (put 'make 'rational
        (lambda (x y)
            (tag (/ x y))))

    ; 提升函数

    (define (rational->real r)
        (make-real r))

    (put 'raise '(rational) rational->real)

'done)

(define (make-rational x y)
    ((get 'make 'rational) x y))
