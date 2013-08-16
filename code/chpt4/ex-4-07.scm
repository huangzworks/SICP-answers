;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.7
;;
;; Let* is similar to let, except that the bindings of
;; the let variables are performed sequentially from left to right,
;; and each binding is made in an environment in which all of the
;; preceding bindings are visible. For example
;;
;; (let* ((x 3)
;;        (y (+ x 2))
;;        (z (+ x y 5)))
;;   (* x z))
;;
;; returns 39. Explain how a let* expression can be rewritten as a set of
;; nested let expressions, and write a procedure let*->nested-lets
;; that performs this transformation. If we have already implemented
;; let (exercise 4.6) and we want to extend the evaluator to handle
;; let*, is it sufficient to add a clause to eval whose action is
;;
;; (eval (let*->nested-lets exp) env)
;;
;; or must we explicitly expand let* in terms of non-derived expressions?
;;
;; =============================================================================


;; Answer : there no need to expand let* in terms of non-derived expressions

;; load let expression handles
(load "ex-4-06.scm")

;; modify the EVAL procedure in order to handle let* expressions
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((let? exp) (eval (let->combination exp) env))
        ((let*? exp) (eval (let*->nested-lets exp) env))
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

;; test if it is a named let expression
(define (let*? exp) (tagged-list? exp 'let*))

;; let* utilities
(define (last-pair-par-arg? pair-par-arg)
  (null? (cdr pair-par-arg)))
(define (let*-pair-par-arg exp) (cadr exp))

;; derivation procedure from named let (let*) expression to nested let expressions
(define (let*->nested-lets exp)
  (if (last-pair-par-arg? (let*-pair-par-arg exp))
      (make-let (let*-pair-par-arg exp) (let-body exp))
      (make-let (list (car (let*-pair-par-arg exp)))
                (list (let*->nested-lets
                       (cons 'let* (cons (cdr (let*-pair-par-arg exp))
                                         (let-body exp))))))))
