;;; 80-install-scheme-number-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-scheme-number-package)

    (define (tag x)
        (attach-tag 'scheme-number x))

    (put 'add '(scheme-number scheme-number)
        (lambda (x y)
            (tag (+ x y))))

    (put 'sub '(scheme-number scheme-number)
        (lambda (x y)
            (tag (- x y))))

    (put 'mul '(scheme-number scheme-number)
        (lambda (x y)
            (tag (* x y))))

    (put 'div '(scheme-number scheme-number)
        (lambda (x y)
            (tag (/ x y))))

    (put 'make 'scheme-number
        (lambda (x)
            (tag x)))

    (put 'equ? '(scheme-number scheme-number)
        (lambda (x y)
            (= x y)))

    ;; 新增

    (put '=zero? '(scheme-number)
        (lambda (value)
            (equ? value 0)))

'done)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))

(define (equ? x y)
    ((get 'equ? '(scheme-number scheme-number)) x y))
