;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.9
;;
;; Many languages support a variety of iteration constructs, such as do, for,
;; while, and until. In Scheme, iterative processes can be expressed in terms
;; of ordinary procedure calls, so special iteration constructs provide no
;; essential gain in computational power. On the other hand, such constructs
;; are often convenient. Design some iteration constructs, give examples of;
;; their use, and show how to implement them as derived expressions.
;;
;; =============================================================================


;; library syntax described in R5RS
;;
;; (do ((<variable1> <init1> <step1>)
;;     ...)
;;    (<test> <expression> ...)
;;  <command> ...)
;;
;; Do is an iteration construct. It specifies a set of variables to be
;; bound, how they are to be initialized at the start, and how they
;; are to be updated on each iteration.
;;
;; When a termination condition is met, the loop exits after
;; evaluating the <expression>s. Do expressions are evaluated as
;; follows:
;;
;; The <init> expressions are evaluated (in some unspecified order),
;; the <variable>s are bound to fresh locations, the results of the
;; <init> expressions are stored in the bindings of the <variable>s,
;; and then the iteration phase begins. Each iteration begins by
;; evaluating <test>, if the result is false, then the <command>
;; expressions are evaluated in order for effect, the <step>
;; expressions are evaluated in some unspecified order, the
;; <variable>s are bound to fresh locations, the results of the
;; <step>s are stored in the bindings of the <variable>s, and the next
;; iteration begins. If <test> evaluates to a true value, then the
;; <expression>s are evaluated from left to right and the value(s) of
;; the last <expression> is(are) returned. If no <expression>s are
;; present, then the value of the do expression is unspecified.
;;
;; The region of the binding of a <variable> consists of the entire do
;; expression except for the <init>s. It is an error for a <variable>
;; to appear more than once in the list of do variables.  A <step> may
;; be omitted, in which case the effect is the same as if (<variable>
;; <init> <variable>) had been written instead of (<variable> <init>).


;; load ex-4-06.scm because we need the let expression with '() binding
(load "ex-4-06.scm")

;; EVAL procedure modifications of the ex-4-06 version
(define (eval exp env)
  (cond ((null? exp) '())    ;; add a null expression test
        ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((let? exp) (eval (let->combination exp) env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((do? exp) (eval (do->combination exp) env))
        ((application? exp)
         (new-apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

;; test if it is a do expression
(define (do? exp) (tagged-list? exp 'do))

;; do utilities
;; extractor of vars from do expression
(define (do-vars exp) (map car (cadr exp)))
;; extractor of inits from do expression
(define (do-inits exp) (map cadr (cadr exp)))
;; extractor of steps from do expression
(define (do-steps exp)
  (map (lambda (var-init-step)
         (if (null? (cddr var-init-step))
             (car var-init-step)
             (caddr var-init-step)))
       (cadr exp)))
;; extractor of the test
(define (do-test exp) (caaddr exp))
;; extractor of the <expressions>
(define (do-exps exp) (cdaddr exp))
;; extractor of the <commands>
(define (do-commands exp) (cdddr exp))

;; derivation from do expression to combination
(define (do->combination exp)
  (make-let '()
            (list (cons 'define
                        (list
                         (cons 'iter (do-vars exp))
                         (make-if (do-test exp)
                                  (sequence->exp (do-exps exp))
                                  (sequence->exp
                                   (list (sequence->exp (do-commands exp))
                                         (cons 'iter (do-steps exp)))))))
                  (cons 'iter (do-inits exp)))))
