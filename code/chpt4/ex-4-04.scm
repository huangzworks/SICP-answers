;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.4
;;
;; Recall the definitions of the special forms and and or from chapter 1:
;;
;; and: The expressions are evaluated from left to right. If any expression
;;      evaluates to false, false is returned; any remaining expressions are
;;      not evaluated. If all the expressions evaluate to true values, the
;;      value of the last expression is returned. If there are no expressions
;;      then true is returned.
;;
;; or: The expressions are evaluated from left to right. If any expression
;;     evaluates to a true value, that value is returned; any remaining
;;     expressions are not evaluated. If all expressions evaluate to false,
;;     or if there are no expressions, then false is returned.
;;
;; Install and and or as new special forms for the evaluator by defining
;; appropriate syntax procedures and evaluation procedures eval-and and
;; eval-or. Alternatively, show how to implement and and or as derived
;; expressions.
;;
;; =============================================================================


;; EVAL procedure modifications
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((and? exp) (eval-and exp env))
        ((and-derived? exp) (eval (and->if exp) env))
        ((or? exp) (eval-or exp env))
        ((or-derived? exp) (eval (or->if exp) env))
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

;; test if it is the special operator 'and' or 'or' expression
(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tagged-list? exp 'or))

;; define special evaluation for the spectial operator 'and'
(define (eval-and exp env)
  (let ((rest (cdr exp)))
    (cond ((null? rest) true)
          ((null? (cdr rest))
           (let ((resultat (eval (car rest) env)))
             (if (true? resultat)
                 resultat
                 false)))
          (else
           (if (eval (car rest) env)
               (eval (cons 'and (cdr rest)) env)
               false)))))
;; define special evaluation for the spectial operator 'or'
(define (eval-or exp env)
  (let ((rest (cdr exp)))
    (cond ((null? rest) false)
          ((null? (cdr rest))
           (if (true? (eval (car rest) env))
               true
               false))
          (else
           (if (true? (eval (car rest) env))
               true
               (eval (cons 'or (cdr rest)) env))))))

;; test if it is the derived special operator 'and' or 'or'
(define (and-derived? exp) (tagged-list? exp 'and-derived))
(define (or-derived? exp) (tagged-list? exp 'or-derived))

;; define the derivation procedure from 'and' to 'if'
(define (and->if exp)
  (if (null? (cdr exp))
      'true
      (if (null? (cddr exp))
          (make-if (cadr exp) (cadr exp) 'false)
          (make-if
           (cadr exp)
           (cons 'and (cddr exp))
           'false))))

;; define the derivation procedure from 'or' to 'if'
(define (or->if exp)
  (if (null? (cdr exp))
      'false
      (make-if
       (cadr exp)
       'true
       (cons 'or (cddr exp)))))
