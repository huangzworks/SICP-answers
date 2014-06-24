;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-25
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.23
;;
;; Alyssa P. Hacker doesn't understand why analyze-sequence needs to
;; be so complicated. All the other analysis procedures are
;; straightforward transformations of the corresponding evaluation
;; procedures (or eval clauses) in section 4.1.1. She expected
;; analyze-sequence to look like this:
;;
(define (analyze-sequence-alyssa exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) ((car procs) env))
          (else ((car procs) env)
                (execute-sequence (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (lambda (env) (execute-sequence procs env))))
;;
;; Eva Lu Ator explains to Alyssa that the version in the text does more
;; of the work of evaluating a sequence at analysis time. Alyssa's
;; sequence-execution procedure, rather than having the calls to the
;; individual execution procedures built in, loops through the
;; procedures in order to call them: In effect, although the
;; individual expressions in the sequence have been analyzed, the
;; sequence itself has not been.

;; Compare the two versions of analyze-sequence. For example, consider
;; the common case (typical of procedure bodies) where the sequence
;; has just one expression. What work will the execution procedure
;; produced by Alyssa's program do? What about the execution procedure
;; produced by the program in the text above? How do the two versions
;; compare for a sequence with two expressions?
;;
;; =============================================================================


;; Understand the phrase 'the sequence itself has not been analyzed.' in detail.
;; The sequence itself has not been analyzed,
;; as consequence, the execute-sequence procedure has to make sure if the
;; sequence only contains one expression (The END test).
;; Recursively, the execute-sequence need to make if test as many times as
;; the number of expressions in the sequence, since (cdr procs) may be also
;; a sequence and itself has not been analyzed yet.
;; However, the END test is exact the 'more work' which has been already done
;; in text's analyze-sequence version.

;; we can compare the efficiency of the two versions of analyze-sequence.

(define (eval-alyssa exp env)
  ((analyze-alyssa exp) env))

(define (analyze-alyssa exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment-alyssa exp))
        ((definition? exp) (analyze-definition-alyssa exp))
        ((if? exp) (analyze-if-alyssa exp))
        ((lambda? exp) (analyze-lambda-alyssa exp))
        ((begin? exp) (analyze-sequence-alyssa (begin-actions exp)))
        ((cond? exp) (analyze-alyssa (cond->if exp)))
        ((application? exp) (analyze-application-alyssa exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define (analyze-assignment-alyssa exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze-alyssa (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

(define (analyze-definition-alyssa exp)
  (let ((var (definition-variable exp))
        (vproc (analyze-alyssa (definition-value exp))))
    (lambda (env)
      (define-variable! var (vproc env) env)
      'ok)))

(define (analyze-if-alyssa exp)
  (let ((pproc (analyze-alyssa (if-predicate exp)))
        (cproc (analyze-alyssa (if-consequent exp)))
        (aproc (analyze-alyssa (if-alternative exp))))
    (lambda (env)
      (if (true? (pproc env))
          (cproc env)
          (aproc env)))))

(define (analyze-lambda-alyssa exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence-alyssa (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))

(define (analyze-application-alyssa exp)
  (let ((fproc (analyze-alyssa (operator exp)))
        (aprocs (map analyze-alyssa (operands exp))))
    (lambda (env)
      (execute-application (fproc env)
                           (map (lambda (aproc) (aproc env))
                                aprocs)))))

;; the mimic interpretator for the optimized EVAL-ALYSSA
;; ATTENTION!!! the global environment is 'the-global-environment-alyssa'
(define (alyssa-driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval-opt input the-global-environment-alyssa)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
