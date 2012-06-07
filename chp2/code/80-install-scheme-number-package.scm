;;; 80-install-scheme-number-package.scm

(load "p123-put-and-get.scm")
(load "p119-tag.scm")

(define (install-scheme-number-package)

    (define (tag x)
        (attach-tag 'scheme-number x))

    (put 'make 'scheme-number
        (lambda (x)
            (tag x)))
    ;; 新增
    (put '=zero? '(scheme-number)
        (lambda (value)
            (= value 0)))

'done)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))
