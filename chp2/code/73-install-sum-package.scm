;;; 73-install-sum-package.scm

(load "p123-put-and-get.scm")
(load "73-tag.scm")         ; 载入 contents 和 attach-tag
(load "p102-number.scm")    ; 载入 =number?

(define (install-sum-package)

    ;;; internal procedures 
    (define (addend s)
        (car s))

    (define (augend s)
        (cadr s))

    (define (make-sum x y)
        (cond ((=number? x 0)
                y)
              ((=number? y 0)
                x)
              ((and (number? x) (number? y))
                (+ x y))
              (else
                (attach-tag '+ x y))))

    ;;; interface to the rest of the system
    (put 'addend '+ addend)
    (put 'augend '+ augend)
    (put 'make-sum '+ make-sum)

    (put 'deriv '+
        (lambda (exp var)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var))))

'done)

(define (make-sum x y)
    ((get 'make-sum '+) x y))

(define (addend sum)
    ((get 'addend '+) (contents sum)))

(define (augend sum)
    ((get 'augend '+) (contents sum)))
