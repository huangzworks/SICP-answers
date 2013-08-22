;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-22
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.20
;;
;; Because internal definitions look sequential but are
;; actually simultaneous, some people prefer to avoid them entirely,
;; and use the special form letrec instead. Letrec looks like let, so
;; it is not surprising that the variables it binds are bound
;; simultaneously and have the same scope as each other. The sample
;; procedure f above can be written without internal definitions, but
;; with exactly the same meaning, as
;;
;; (define (f x)
;;   (letrec ((even?
;;             (lambda (n)
;;               (if (= n 0)
;;                   true
;;                   (odd? (- n 1)))))
;;            (odd?
;;             (lambda (n)
;;               (if (= n 0)
;;                   false
;;                   (even? (- n 1))))))
;;     <rest of body of f>))
;;
;; Letrec expressions, which have the form
;;
;; (letrec ((<var1> <exp1>) ... (<varn> <expn>))
;;   <body>)
;;
;; are a
;; VARIATION ON LET IN WHICH THE EXPRESSIONS <EXPK> THAT PROVIDE
;; THE INITIAL VALUES FOR THE VARIABLES <VARK> ARE EVALUATED IN AN
;; ENVIRONMENT THAT INCLUDES ALL THE LETREC BINDINGS.
;; This permits recursion in the bindings, such as the mutual
;; recursion of even?  and odd? in the example above, or the
;; evaluation of 10 factorial with
;;
;; (letrec ((fact
;;           (lambda (n)
;;             (if (= n 1)
;;                 1
;;                 (* n (fact (- n 1)))))))
;;   (fact 10))
;;
;; a. Implement letrec as a derived expression, by transforming a letrec
;; expression into a let expression as shown in the text above or in
;; exercise 4.18. That is, the letrec variables should be created with
;; a let and then be assigned their values with set!.

;; b. Louis Reasoner is confused by all this fuss about internal
;; definitions. The way he sees it, if you don't like to use define
;; inside a procedure, you can just use let. Illustrate what is loose
;; about his reasoning by drawing an environment diagram that shows
;; the environment in which the <rest of body of f> is evaluated
;; during evaluation of the expression (f 5), with f defined as in
;; this exercise. Draw an environment diagram for the same evaluation,
;; but with let in place of letrec in the definition of f.
;;
;; =============================================================================

;; modifiy the EVAL procedure in ex-4.6 to cope with letrec expression
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((and? exp) (eval-and exp env))       ;; needed for test use
        ((or? exp) (eval-or exp env))
        ((if? exp) (eval-if exp env))
        ((letrec? exp) (eval (letrec->let-let exp) env))
        ((let? exp) (eval (let->combination exp) env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (new-apply (eval (operator exp) env)       ;;'new-apply' see ATTENTION
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))


;; test if it is a letrec expression
(define (letrec? exp) (tagged-list? exp 'letrec))

;; letrec utilities
(define (letrec-vars exp)
  (if (null? (cadr exp))
      '()
      (map car (cadr exp))))

(define (letrec-inits exp)
  (if (null? (cadr exp))
      '()
      (map cadr (cadr exp))))

(define (letrec-body exp) (cddr exp))

;; a. derive the letrec expression as described in ex 4.18
;; do NOT use strings that begin with "--" as variable name
;; as these name are regarded as reserved
(define (letrec->let-let exp)
  (let ((vars (letrec-vars exp)))
    (if (null? vars)
        (make-let '() (letrec-body exp))
        (let ((new-vars
               (map (lambda (x) (string->symbol (string "--" x)))
                    vars)))
                    (make-let (map (lambda (x) (list x ''*unassigned*)) vars)
                              (cons (make-let
                                     (map (lambda (x y) (list x y))
                                          new-vars
                                          (letrec-inits exp))
                                     (map (lambda (x y) (list 'set! x y))
                                          vars
                                          new-vars))
                                    (letrec-body exp)))))))



