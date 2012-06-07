;;; 79-install-scheme-number-package.scm

(load "p123-put-and-get.scm")
(load "p119-tag.scm")

(define (install-scheme-number-package)

    ;; internal procedures
    (define (tag x)
        (attach-tag 'scheme-number x))

    ;; interface to rest of the system
    (put 'make 'scheme-number
        (lambda (x)
            (tag x)))

    ;; 新增
    (put 'equ? '(scheme-number scheme-number)
        (lambda (x y)
            (= x y)))

'done)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))
