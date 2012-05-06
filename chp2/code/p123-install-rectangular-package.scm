;;; p123-install-rectangular-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-rectangular-package)
    ;; internal procedures
    (define (real-part z)
        (car z))

    (define (imag-part z)
        (cdr z))
    
    (define (make-from-real-imag x y)   
        (cons x y))

    (define (magnitude z)
        (sqrt (+ (square (real-part z))
                 (square (imag-part z)))))

    (define (angle z)
        (atan (imag-part z) (real-part z)))

    (define (make-from-mag-ang r a)
        (cons (* r (cos a)) (* r (sin a))))

    ;; interface to the rest of the system
    (define (tag x)
        (attach-tag 'rectangular x))

    (put 'real-part '(rectangular) real-part)

    (put 'imag-part '(rectangular) imag-part)

    (put 'magnitude '(rectangular) magnitude)

    (put 'angle '(rectangular) angle)

    (put 'make-from-real-imag 'rectangular
        (lambda (x y)
            (tag (make-from-real-imag x y))))

    (put 'make-from-mag-ang 'rectangular
        (lambda (r a)
            (tag (make-from-mag-ang r a))))

'done)

(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
