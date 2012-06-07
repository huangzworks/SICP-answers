;;; 78-type-tag.scm

(define (type-tag datum)
    (cond ((number? datum)
            'scheme-number)
          ((pair? datum)
            (car datum))
          (else
            (error "Bad tagged datum -- TYPE-TAG" datum))))
