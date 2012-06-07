;;; 79-install-rational-package.scm

(load "p123-put-and-get.scm")
(load "p119-tag.scm")

(define (install-rational-package)
    
    ;; internal procedures
    (define (numer x)
        (car x))

    (define (denom x)
        (cdr x))

    (define (make-rat n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))

    ;; interface to rest of the system
    (define (tag x)
        (attach-tag 'rational x))

    (put 'make 'rational
        (lambda (n d)
            (tag (make-rat n d))))

    ;; 新增
    (put 'equ? '(rational rational)
        (lambda (x y)
            (and (= (numer x) (numer y))
                 (= (denom x) (denom y)))))

'done)

(define (make-rational n d)
    ((get 'make 'rational) n d))
