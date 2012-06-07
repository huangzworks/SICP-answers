;;; 81-louis-coercion.scm

(load "p133-coercion.scm")

(define (scheme-number->scheme-number n)
    n)

(put-coercion 'scheme-number 'scheme-number 
              scheme-number->scheme-number)
