;;;; MEVAL.SCM

;;; Basic Metacircular Evaluator from section 4.1,
;;; Extended with Lazy Parameter Declarations
;;; as in Exercise 4.14

(load "analyze.scm")
(load "evdata.scm")
(load "syntax.scm")

(define (meval exp env)
  (cond ((self-evaluating? exp) exp)
        ((quoted? exp) (text-of-quotation exp))
        ((variable? exp) (lookup-variable-value exp env))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp) (lambda-body exp) env))
        ((begin? exp) (eval-sequence (begin-actions exp) env))
        ((cond? exp) (meval (cond->if exp) env))
        ((let? exp) (meval (let->combination exp) env))
        ((application? exp)
         (m-apply (meval (operator exp) env)
                  (value-procs (operands exp))
                     ;this postpones argument evaluation until
                     ;parameter declarations are processed
                  env))
        (else (error "Unknown expression type -- MEVAL"))))


(define (value-procs exps)
  (map
   (lambda (exp) (lambda (env) (meval exp env)))
   exps))


(define (m-apply procedure aprocs env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (force-all-args aprocs env)))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (let ((params (procedure-parameters procedure)))
            (extend-environment (parameter-names params)
                                (process-arg-procs params aprocs env)
                                (procedure-environment procedure)))))
        (else (error "Unknown procedure type -- M-APPLY"))))


(define (eval-if exp env)
  (if (true? (force-it (meval (if-predicate exp) env)))
      (meval (if-consequent exp) env)
      (meval (if-alternative exp) env)))


(define (eval-sequence exps env)
  (cond ((last-exp? exps) (meval (first-exp exps) env)) ;CORRECTED to eliminate forcing
                                                        ;the last expression
        (else (force-it (meval (first-exp exps) env))
              (eval-sequence (rest-exps exps) env))))


(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (meval (assignment-value exp) env)
                       env))


(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (meval (definition-value exp) env)
                    env))


(define (start-meval)
  (set! current-evaluator meval)
  (set! current-prompt "MEVAL=> ")
  (set! current-value-label ";;M-value: ")
  (init-env)
  (eval-loop))
