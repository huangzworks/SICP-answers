;;; 73-install-product-package.scm

(load "p123-put-and-get.scm")
(load "73-tag.scm")             ; 载入 attach-tag 和 contents
(load "p102-number.scm")        ; 载入 =number?

(define (install-product-package)

    ;;; internal procedures
    (define (multiplier p)
        (car p))

    (define (multiplicand p)
        (cadr p))

    (define (make-product x y)
        (cond ((or (=number? x 0) (=number? y 0))
                0)
              ((=number? x 1)
                y)
              ((=number? y 1)
                x)
              ((and (number? x) (number? y))
                (* x y))
              (else
                (attach-tag '* x y))))

    ;;; interface to the rest of the system
    (put 'multiplier '* multiplier)
    (put 'multiplicand '* multiplicand)
    (put 'make-product '* make-product)

    (put 'deriv '*
        (lambda (exp var)
            (make-sum
                (make-product (multiplier exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multiplier exp) var)
                              (multiplicand exp)))))

'done)

(define (make-product x y)
    ((get 'make-product '*) x y))

(define (multiplier product)
    ((get 'multiplier '*) (contents product)))

(define (multiplicand product)
    ((get 'multiplicand '*) (contents product)))
