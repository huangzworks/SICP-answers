;;; 73-deriv.scm

(load "p123-put-and-get.scm")

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
            (if (same-variable? exp var) 1 0))
          (else
            ((get 'deriv (operator exp))
                (operands exp)
                var))))

(define (operator exp)
    (car exp))

(define (operands exp)
    (cdr exp))

;;; 以下函数来自书本 100 页

(define (same-variable? v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2)))

(define (variable? x)
    (symbol? x))
