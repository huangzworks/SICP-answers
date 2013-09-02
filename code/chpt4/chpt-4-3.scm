;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;                   Chapter 4 Metalinguistic Abstraction
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;==============================================================================
;; 4.3  Variations on a Scheme -- Nondeterministic Computing
;;==============================================================================

;;------------------------------------------------------------------------------
;; 4.3.1  Amb and Search
;;------------------------------------------------------------------------------

(define (require p)
  (if (not p) (amb)))

;;------------------------------------------------------------------------------
;; 4.3.2  Examples of Nondeterministic Programs
;;------------------------------------------------------------------------------

;;------------------------------------------------------------------------------
;; 4.3.3  Implementing the Amb Evaluator
;;------------------------------------------------------------------------------
;; p297

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Structure of the evaluator
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; The syntax- and data-representation procedures for the amb
;; evaluator, and also the basic analyze procedure, are identical to
;; those in the evaluator of section 4.1.7, except for the fact that
;; we need additional syntax procedures to recognize the amb special
;; form

(load "chpt-4-1.scm")

;; load let handles
(load "ex-4-22.scm")

(define (amb? exp) (tagged-list? exp 'amb))
(define (amb-choices exp) (cdr exp))

;; We must also add to the dispatch in analyze a clause that will
;; recognize this special form and generate an appropriate execution
;; procedure:
;; ((amb? exp) (analyze-amb exp))

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((amb? exp) (analyze-amb exp))
        ((if? exp) (analyze-if exp))
        ((let? exp) (analyze (let->combination exp)))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

;; The top-level procedure ambeval (similar to the version of eval given
;; in section 4.1.7) analyzes the given expression and applies the
;; resulting execution procedure to the given environment, together
;; with two given continuations:

(define (ambeval exp env succeed fail)
  ((analyze exp) env succeed fail))

;; A success continuation is a procedure of two arguments: the value just
;; obtained and another failure continuation to be used if that value
;; leads to a subsequent failure. A failure continuation is a
;; procedure of no arguments. So the general form of an execution
;; procedure is
;;
;; (lambda (env succeed fail)
;;   ;; succeed is (lambda (value fail) ...)
;;   ;; fail is (lambda () ...)
;;   ...)
;;
;; For example, executing
;;
;; (ambeval <exp>
;;          the-global-environment
;;          (lambda (value fail) value)
;;          (lambda () 'failed))
;;
;; will attempt to evaluate the given expression and will return either
;; the expression's value (if the evaluation succeeds) or the symbol
;; failed (if the evaluation fails). The call to ambeval in the driver
;; loop shown below uses much more complicated continuation
;; procedures, which continue the loop and support the try-again
;; request.
;;
;; Most of the complexity of the amb evaluator results from the mechanics
;; of passing the continuations around as the execution procedures
;; call each other. In going through the following code, you should
;; compare each of the execution procedures with the corresponding
;; procedure for the ordinary evaluator given in section 4.1.7.

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Simple expressions
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; The execution procedures for the simplest kinds of expressions are
;; essentially the same as those for the ordinary evaluator, except
;; for the need to manage the continuations. The execution procedures
;; simply succeed with the value of the expression, passing along the
;; failure continuation that was passed to them.

;; ADD MY OWN EXPLANATION
(define (analyze-self-evaluating exp)
  (lambda (env succeed fail)
    (succeed exp fail)))
(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env succeed fail)
      (succeed qval fail))))
(define (analyze-variable exp)
  (lambda (env succeed fail)
    (succeed (lookup-variable-value exp env)
             fail)))
(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env succeed fail)
      (succeed (make-procedure vars bproc env)
               fail))))

;; Notice that looking up a variable always ``succeeds.'' If
;; lookup-variable-value fails to find the variable, it signals an
;; error, as usual. Such a ``failure'' indicates a program bug -- a
;; reference to an unbound variable, it is not an indication that we
;; should try another nondeterministic choice instead of the one that
;; is currently being tried.

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Conditionals and sequences
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Conditionals are also handled in a similar way as in the ordinary
;; evaluator. The execution procedure generated by analyze-if invokes
;; the predicate execution procedure pproc with a success continuation
;; that checks whether the predicate value is true and goes on to
;; execute either the consequent or the alternative. If the execution
;; of pproc fails, the original failure continuation for the if
;; expression is called.

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succeed fail)
      (pproc env
             ;; success continuation for evaluating the predicate
             ;; to obtain pred-value
             (lambda (pred-value fail2)
               (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
             ;; failure continuation for evaluating the predicate
             fail))))

;; Sequences are also handled in the same way as in the previous
;; evaluator, except for the machinations in the subprocedure
;; sequentially that are required for passing the
;; continuations. Namely, to sequentially execute a and then b, we
;; call a with a success continuation that calls b.

(define (analyze-sequence exps)
  (define (sequentially a b)
    (lambda (env succeed fail)
      (a env
         ;; success continuation for calling a
         (lambda (a-value fail2)
           (b env succeed fail2))
         ;; failure continuation for calling a
         fail)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))


;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Definitions and assignments
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Definitions are another case where we must go to some trouble to
;; manage the continuations, because it is necessary to evaluate the
;; definition-value expression before actually defining the new
;; variable. To accomplish this, the definition-value execution
;; procedure vproc is called with the environment, a success
;; continuation, and the failure continuation. If the execution of
;; vproc succeeds, obtaining a value val for the defined variable, the
;; variable is defined and the success is propagated:

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (define-variable! var val env)
               (succeed 'ok fail2))
             fail))))

;; Assignments are more interesting. This is the first place where we
;; really use the continuations, rather than just passing them
;; around. The execution procedure for assignments starts out like the
;; one for definitions. It first attempts to obtain the new value to
;; be assigned to the variable. If this evaluation of vproc fails, the
;; assignment fails.
;;
;; If vproc succeeds, however, and we go on to make the assignment, we
;; must consider the possibility that this branch of the computation
;; might later fail, which will require us to backtrack out of the
;; assignment. Thus, we must arrange to undo the assignment as part of
;; the backtracking process.57
;;
;; This is accomplished by giving vproc a success continuation (marked
;; with the comment ``*1*'' below) that saves the old value of the
;; variable before assigning the new value to the variable and
;; proceeding from the assignment. The failure continuation that is
;; passed along with the value of the assignment (marked with the
;; comment ``*2*'' below) restores the old value of the variable
;; before continuing the failure. That is, a successful assignment
;; provides a failure continuation that will intercept a subsequent
;; failure, whatever failure would otherwise have called fail2 calls
;; this procedure instead, to undo the assignment before actually
;; calling fail2.

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (let ((old-value
                      (lookup-variable-value var env)))
                 (set-variable-value! var val env)
                 (succeed 'ok
                          (lambda ()
                            (set-variable-value! var
                                                 old-value
                                                 env)
                            (fail2)))))
             fail))))


;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Procedure applications
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; The execution procedure for applications contains no new ideas except
;; for the technical complexity of managing the continuations. This
;; complexity arises in analyze-application, due to the need to keep
;; track of the success and failure continuations as we evaluate the
;; operands. We use a procedure get-args to evaluate the list of
;; operands, rather than a simple map as in the ordinary evaluator.

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env succeed fail)
      (fproc env
             (lambda (proc fail2)
               (get-args aprocs
                         env
                         (lambda (args fail3)
                           (execute-application
                            proc args succeed fail3))
                         fail2))
             fail))))

;; In get-args, notice how cdring down the list of aproc execution
;; procedures and consing up the resulting list of args is
;; accomplished by calling each aproc in the list with a success
;; continuation that recursively calls get-args. Each of these
;; recursive calls to get-args has a success continuation whose value
;; is the cons of the newly obtained argument onto the list of
;; accumulated arguments:

(define (get-args aprocs env succeed fail)
  (if (null? aprocs)
      (succeed '() fail)
      ((car aprocs) env
                    ;; success continuation for this aproc
                    (lambda (arg fail2)
                      (get-args (cdr aprocs)
                                env
                                ;; success continuation for recursive
                                ;; call to get-args
                                (lambda (args fail3)
                                  (succeed (cons arg args)
                                           fail3))
                                fail2))
                    fail)))

;; The actual procedure application, which is performed by
;; execute-application, is accomplished in the same way as for the
;; ordinary evaluator, except for the need to manage the
;; continuations.

(define (execute-application proc args succeed fail)
  (cond ((primitive-procedure? proc)
         (succeed (apply-primitive-procedure proc args)
                  fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              args
                              (procedure-environment proc))
          succeed
          fail))
        (else
         (error
          "Unknown procedure type -- EXECUTE-APPLICATION"
          proc))))

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Evaluating amb expressions
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; The amb special form is the key element in the nondeterministic
;; language. Here we see the essence of the interpretation process and
;; the reason for keeping track of the continuations. The execution
;; procedure for amb defines a loop try-next that cycles through the
;; execution procedures for all the possible values of the amb
;; expression. Each execution procedure is called with a failure
;; continuation that will try the next one. When there are no more
;; alternatives to try, the entire amb expression fails.

(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices))))))
      (try-next cprocs))))

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Driver loop
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; The driver loop for the amb evaluator is complex, due to the mechanism
;; that permits the user to try again in evaluating an expression. The
;; driver uses a procedure called internal-loop, which takes as
;; argument a procedure try-again. The intent is that calling
;; try-again should go on to the next untried alternative in the
;; nondeterministic evaluation. Internal-loop either calls try-again
;; in response to the user typing try-again at the driver loop, or
;; else starts a new evaluation by calling ambeval.
;;
;; The failure continuation for this call to ambeval informs the user
;; that there are no more values and re-invokes the driver loop.
;;
;; The success continuation for the call to ambeval is more subtle. We
;; print the obtained value and then invoke the internal loop again
;; with a try-again procedure that will be able to try the next
;; alternative. This next-alternative procedure is the second argument
;; that was passed to the success continuation. Ordinarily, we think
;; of this second argument as a failure continuation to be used if the
;; current evaluation branch later fails. In this case, however, we
;; have completed a successful evaluation, so we can invoke the
;; ``failure'' alternative branch in order to search for additional
;; successful evaluations.

(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")
(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (eq? input 'try-again)
          (try-again)
          (begin
            (newline)
            (display ";;; Starting a new problem ")
            (ambeval input
                     the-global-environment
                     ;; ambeval success
                     (lambda (val next-alternative)
                       (announce-output output-prompt)
                       (user-print val)
                       (internal-loop next-alternative))
                     ;; ambeval failure
                     (lambda ()
                       (announce-output
                        ";;; There are no more values of")
                       (user-print input)
                       (driver-loop)))))))
  (internal-loop
   (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop))))

;; The initial call to internal-loop uses a try-again procedure that
;; complains that there is no current problem and restarts the driver
;; loop. This is the behavior that will happen if the user types
;; try-again when there is no evaluation in progress.
