;;; 83-install-real-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-real-package)
    
    (define (tag x)
        (attach-tag 'real x))

    (put 'make 'real
        (lambda (n)
            (tag (exact->inexact n))))

    ; 提升函数

    (define (real->complex r)
        (make-complex r 0))

    (put 'raise '(real) real->complex)

'done)

(define (make-real n)
    ((get 'make 'real) n))
