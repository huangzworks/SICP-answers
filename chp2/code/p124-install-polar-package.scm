;;; p124-install-polar-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-polar-package)
    ;;; internal procedures
    (define (magnitude z)
        (car z))

    (define (angle z)
        (cdr z))

    (define (make-from-mag-ang r a)
        (cons r a))

    (define (real-part z)
        (* (magnitude z) (cos (angle z))))

    (define (imag-part z)
        (* (magnitude z) (sin (angle z))))

    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
              (atan y x)))

    ;; interface to the rest of the system
    (define (tag x)
        (attach-tag 'polar x))

    (put 'real-part '(polar) real-part)

    (put 'imag-part '(polar) imag-part)

    (put 'magnitude '(polar) magnitude)

    (put 'angle '(polar) angle)
    
    (put 'make-from-real-imag 'polar
        (lambda (x y)
            (tag (make-from-real-imag x y))))

    (put 'make-from-mag-ang 'polar
        (lambda (r a)
            (tag (make-from-mag-ang r a))))

'done)

(define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
