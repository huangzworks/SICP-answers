;;; 73-install-product-pack.scm

(define (install-product-pack)
    ;;; internal procedures

    (define (multiplier p)
        (car p))

    (define (multiplicand p)
        (cadr p))

    (define (make-product x y)
        (list '* x y))

    ;;; interface to the rest of the system

    (put 'deriv '*
        (lambda (exp var)
            (make-sum
                (make-product (multiplier exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multiplier exp) var)
                              (multiplicand exp)))))

'done)

(define (make-sum x y)
    ((get 'make-sum '+) x y))
