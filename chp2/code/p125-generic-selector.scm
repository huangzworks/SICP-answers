;;; p125-generic-selector.scm

(define (real-part z)
    (apply-generic 'real-part z))

(define (imag-part z)
    (apply-generic 'imag-part z))

(define (magnitude z)
    (apply-generic 'magnitude z))

(define (angle z)
    (apply-generic 'angle z))
