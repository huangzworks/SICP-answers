;;; ANALYZE.SCM

;;; Analyzing Interpreter from Section 4.2.2
;;; with Lazy Parameter Declarations as in Exercise 4.14

;;; Produces (lambda (env) ...)
(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((variable? exp) (analyze-variable exp))
        ((quoted? exp) (analyze-quoted exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (COND->IF exp)))
        ((let? exp) (analyze (LET->combination exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))


(define (analyze-self-evaluating exp)
  (lambda (env) exp))


(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env) qval)))


(define (analyze-variable exp)
  (lambda (env)
    (lookup-variable-value exp env)))


(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env))))


(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env)
      (define-variable! var (vproc env) env))))


(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env)
      (make-procedure vars bproc env))))


(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env)
      (if (force-it (pproc env))
          (cproc env)
          (aproc env)))))


(define (analyze-sequence exps)
  (define (sequentially a b)
    (lambda (env) (force-it (a env)) (b env)))
  (let ((procs (map analyze exps)))
    (define (loop first rest)
      (if (null? rest)
          first
          (loop (sequentially first (car rest))
                (cdr rest))))
    (if (null? procs)
        (error
         "BEGIN requires subexpressions -- ANALYZE" exps))
    (loop (car procs) (cdr procs))))


(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env)
      (exapply (force-it (fproc env)) aprocs env))))


(define (exapply proc aprocs env)
  (cond ((primitive-procedure? proc)
	 (apply-primitive-procedure
          proc
          (force-all-args aprocs env)))
	((compound-procedure? proc)
	 (let ((params (procedure-parameters proc)))
	   ((procedure-body proc)
	    (extend-environment (parameter-names params)
				(process-arg-procs params aprocs env)
				(procedure-environment proc)))))
	(else
	 (error "Unknown procedure type -- EXAPPLY"
		proc))))


(define (start-analyze)
  (set! current-evaluator (lambda (exp env) ((analyze exp) env)))
  (set! current-prompt "AEVAL=> ")
  (set! current-value-label ";;A-value: ")
  (init-env)
  (eval-loop))
