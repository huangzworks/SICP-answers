;;; 73-install-exponentiation-package.scm

(load "p123-put-and-get.scm")
(load "73-tag.scm")

(define (install-exponentiation-package)

    ;;; internal procedures
    (define (base exp)
        (car exp))

    (define (exponent exp)
        (cadr exp))

    (define (make-exponentiation base n)
        (cond ((= n 0)
                0)
              ((= n 1)
                base)
              (else
                (attach-tag '** base n))))

    ;;; interface to the rest of the system
    (put 'base '** base)
    (put 'exponent '** exponent)
    (put 'make-exponentiation '** make-exponentiation)

    (put 'deriv '**
         (lambda (exp var)
            (let ((n (exponent exp))
                  (u (base exp)))
                (make-product
                    n
                    (make-product
                        (make-exponentiation
                            u
                            (- n 1))
                        (deriv u var))))))

'done)

(define (make-exponentiation base n)
    ((get 'make-exponentiation '**) base n))

(define (base exp)
    ((get 'base '**) (contents exp)))

(define (exponent exp)
    ((get 'exponent '**) (contents exp)))
