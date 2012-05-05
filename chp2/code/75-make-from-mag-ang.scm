;;; 75-make-from-mag-ang.scm

(define (make-from-mag-ang x y)
    (define (dispatch op)
        (cond ((eq? op 'real-part)
                (* x (cos y)))
              ((eq? op 'imag-part)
                (* x (sin y)))
              ((eq? op 'magnitude)
                x)
              ((eq? op 'angle)
                y)
              (else
                (error "Unkonw op  -- MAKE-FROM-MAG-ANG" op))))
    dispatch)
