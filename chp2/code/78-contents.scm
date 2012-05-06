;;; 78-contents.scm

(define (contents datum)
    (cond ((number? datum)
            datum)
          ((pair? datum)
            (cdr datum))
          (else
            (error "Bad tagged datum -- CONTENT" datum))))
