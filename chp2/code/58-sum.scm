;;; 58-sum.scm

(define (make-sum a1 a2)
    (cond ((=number? a1 0)
            a2)
          ((=number? a2 0)
            a1)
          ((and (number? a1) (number? a2))
            (+ a1 a2))
          (else
            (list a1 '+ a2))))              ; 修改

(define (sum? x)
    (and (pair? x)
         (eq? (cadr x) '+)))                ; 修改

(define (addend s)
    (car s))                                ; 修改

(define (augend s)
    (caddr s))
