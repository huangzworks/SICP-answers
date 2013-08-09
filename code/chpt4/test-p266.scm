
(load "Chpt-4-1.scm")

(define the-global-environment (setup-environment))

(eval
'(define (append x y)
   (if (null? x)
       y
       (cons (car x)
             (append (cdr x) y))))
the-global-environment
)


(newline)
(display ";;; you should see : (a b c d e f)")
(newline)

(eval
'(append '(a b c) '(d e f))
the-global-environment
)
