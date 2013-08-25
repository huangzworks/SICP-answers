;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;                   Chapter 4 Metalinguistic Abstraction
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;===============================================================================
;; 4.1 The Metacircular Evaluator
;;===============================================================================

;;-------------------------------------------------------------------------------
;; 4.1.1  The Core of the Evaluator
;;-------------------------------------------------------------------------------
;; p253

;; EVAL: Takes as arguments an expression and an environment.

;; It classifies the expression and directs its evaluation.
;; Eval is structured as a case analysis of the syntactic type of the expression\
;; to be evaluated.
;; In order to keep the procedure general, we express the determination of the\
;; type of an expression abstractly, making no commitment to any particular\
;; representation for the various types of expressions.
;; Each type of expression has a predicate that tests for it and an abstract\
;; means for selecting its parts. This abstract syntax makes it easy to see how\
;; we can change the syntax of the language by using the same evaluator,\
;; but with a different collection of syntax procedures.

;; Primitive expressions
;;   self-evaluating expressions
;;   variables

;; Special forms
;;   quoted expressions
;;   an assignment to (or a definition of) a variable
;;   if expression
;;   lambda expression
;;   begin expression
;;   case analysis (cond)

;; Combinations
;;   procedure application

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
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


;; APPLY: takes two arguments, a procedure and a list of arguments to which the\
;;        procedure should be applied.

;; Apply classifies procedures into two kinds:
;; It calls apply-primitive-procedure to apply primitives;
;; It applies compound procedures by sequentially evaluating the expressions\
;; that make up the body of the procedure.
;; The environment for the evaluation of the body of a compound procedure is\
;; constructed by extending the base environment carried by the procedure to\
;; include a frame that binds the parameters of the procedure to the arguments\
;; to which the procedure is to be applied.

;; ATTENTION: Here we use 'new-apply' as the name of the APPLY procedure\
;;            since there is an original 'apply' in scheme, and later we should\
;;            refer to this original 'apply' in apply-primitive-procedure,\
;;            otherwise, our newly defined 'apply' will cover the original one.\
;; see footnote 17:
;; http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-26.html#footnote_Temp_550
;; or footnote 221 on p265 of the chinese version SICP book

(define (new-apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
        (else
          (error "Unknown procedure type -- NEW-APPLY" procedure))))


;; p254

;; LIST-OF_VALUES: takes as an argument the operands of the combination.

;; It evaluates each operand and returns a list of the corresponding values:5
;; since eval must recursively evaluate the operands of the combination.

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))


;; EVAL-IF:

;; evaluates the predicate part of an if expression in the given environment.
;; If the result is true, eval-if evaluates the consequent,
;;  otherwise it evaluates the alternative:

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))


;; EVAL-SEQUENCE: takes as arguments a sequence of expressions and an environment

;; evaluates the expressions in the order in which they occur.
;; The value returned is the value of the final expression
;; It is used by new-apply to evaluate the sequence of expressions in a\
;; procedure body and by eval to evaluate the sequence of expressions in\
;; a begin expression.

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))


;; EVAL-ASSIGNMENT:

;; It calls eval to find the value to be assigned and transmits the variable\
;; and the resulting value to set-variable-value! to be installed in the\
;; designated environment.

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (eval (assignment-value exp) env)
                       env)
  'ok)


;; EVAL-DEFINITION:

;; similar to eval-assignment

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (eval (definition-value exp) env)
                    env)
  'ok)


;;-------------------------------------------------------------------------------
;; 4.1.2  Representing Expressions
;;-------------------------------------------------------------------------------
;; p255

;; The only self-evaluating items are numbers and strings:

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

;; Variables are represented by symbols:

(define (variable? exp) (symbol? exp))

;; Quotations have the form
;; (quote <text-of-quotation>)

(define (quoted? exp)
  (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

;; p256

;; Assignments have the form
;; (set! <var> <value>)

(define (assignment? exp)
  (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

;; Definitions have the form
;; (define <var> <value>)
;; or the form
;; (define (<var> <parameter1> ... <parametern>) <body>)

(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)     ; formal parameters
                   (cddr exp))))   ; body

;; Lambda expressions are lists that begin with the symbol lambda

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;; p257

;; Conditionals begin with if and have a predicate, a consequent,\
;; and an (optional) alternative. If the expression has no alternative part,\
;; we provide false as the alternative.

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;; Begin packages a sequence of expressions into a single expression.
;; We include syntax operations on begin expressions to extract the actual\
;; sequence from the begin expression, as well as selectors that return\
;; the first expression and the rest of the expressions in the sequence.

(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

;; A procedure application is any compound expression that is not one of\
;; the above expression types. The car of the expression is the operator,\
;; and the cdr is the list of operands:

(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

;; p258

;; Derived expressions

;; COND can be implemented as a nest of if expressions.
;; We include syntax procedures that extract the parts of a cond expression,\
;; and a procedure cond->if that transforms cond expressions into if expressions.
;; A case analysis begins with cond and has a list of predicate-action clauses.
;; A clause is an else clause if its predicate is the symbol else.

(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clauses isn't last -- COND->IF" clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))


;;-------------------------------------------------------------------------------
;; 4.1.3  Evaluator Data Structures
;;-------------------------------------------------------------------------------
;; p261

;; Testing of predicates
;; For conditionals, we accept anything to be true that is not
;; the explicit false object

(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))

;; Representing procedures
;; Compound procedures are constructed from parameters, procedure bodies,
;; and environments using the constructor make-procedure:

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

;; Operations on Environments
;; The evaluator needs operations for manipulating environments.
;; As explained in section 3.2, an environment is a sequence of frames,
;; where each frame is a table of bindings that associate variables
;; with their corresponding values.
;; To implement these operations we represent an environment as a list of frames.
;; The enclosing environment of an environment is the cdr of the list.
;; The empty environment is simply the empty list.

(define (enclosing-environment env) (cdr env))  ;; enclosing environment
(define (first-frame env) (car env))
(define the-empty-environment '())

;; Frame
;; Each frame of an environment is represented as a pair of lists:
;; a list of the variables bound in that frame and
;; a list of the associated values.

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))


;; To extend an environment by a new frame that associates variables with values,
;; we make a frame consisting of the list of variables and the list of values,
;; and we adjoin this to the environment. We signal an error if the number of
;; variables does not match the number of values.

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

;; To look up a variable in an environment, we scan the list of
;; variables in the first frame. If we find the desired variable, we
;; return the corresponding element in the list of values. If we do
;; not find the variable in the current frame, we search the enclosing
;; environment, and so on. If we reach the empty environment, we
;; signal an ``unbound variable'' error.

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;; To set a variable to a new value in a specified environment,
;; we scan for the variable, just as in lookup-variable-value,
;; and change the corresponding value when we find it.

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;; To define a variable, we search the first frame for a binding for the
;; variable,and change the binding if it exists (just as in set-variable-value!).
;; If no such binding exists, we adjoin one to the first frame.

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))


;;-------------------------------------------------------------------------------
;; 4.1.4  Running the Evaluator as a Program
;;-------------------------------------------------------------------------------

;; set up a global environment that associates unique objects with the names of
;; the primitive procedures that can appear in the expressions we will be
;; evaluating. The global environment also includes bindings for the symbols
;; true and false, so that they can be used as variables in expressions
;; to be evaluated.

(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

;; It does not matter how we represent the primitive procedure objects,
;; so long as apply can identify and apply them by using the procedures
;; primitive-procedure? and apply-primitive-procedure.
;; We have chosen to represent a primitive procedure as a list beginning
;; with the symbol primitive and containing a procedure in the underlying
;; Lisp that implements that primitive

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define (primitive-implementation proc) (cadr proc))
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
  ))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

;; To apply a primitive procedure, we simply apply the implementation
;; procedure to the arguments, using the underlying Lisp system

(define (apply-primitive-procedure proc args)
  (apply
    (primitive-implementation proc) args))

;; For convenience in running the metacircular evaluator,
;; we provide a driver loop that models the read-eval-print loop of
;; the underlying Lisp system. It prints a prompt, reads an input expression,
;; evaluates this expression in the global environment, and prints the result.
;; We precede each printed result by an output prompt so as to distinguish
;; the value of the expression from other output that may be printed.

(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define (announce-output string)
  (newline) (display string) (newline))
(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
		     (procedure-parameters object)
		     (procedure-body object)
		     '<procedure-env>))
      (display object)))


;;-------------------------------------------------------------------------------
;; 4.1.5  Data as Programs
;;-------------------------------------------------------------------------------

;;-------------------------------------------------------------------------------
;; 4.1.6  Internal Definitions
;;-------------------------------------------------------------------------------

;;-------------------------------------------------------------------------------
;; 4.1.7 Separating Syntactic Analysis from Execution
;;-------------------------------------------------------------------------------
;; p273

;; We can transform the evaluator to be significantly more efficient
;; by arranging things so that syntactic analysis is performed only
;; once.28 We split eval, which takes an expression and an
;; environment, into two parts. The procedure analyze takes only the
;; expression. It performs the syntactic analysis and returns a new
;; procedure, the execution procedure, that encapsulates the work to
;; be done in executing the analyzed expression. The execution
;; procedure takes an environment as its argument and completes the
;; evaluation. This saves work because analyze will be called only
;; once on an expression, while the execution procedure may be called
;; many times.

;; EVAL-OPT: With the separation into analysis and execution now

(define (eval-opt exp env)
  ((analyze exp) env))

;; The result of calling analyze is the execution procedure to be
;; applied to the environment. The analyze procedure is the same case
;; analysis as performed by the original eval of section 4.1.1, except
;; that the procedures to which we dispatch perform only analysis, not
;; full evaluation:

;; ANALYZE: only analysis, not full evaluation
(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

;; p274

;; ANALYZE-SELF-EVALUATING
;; It returns an execution procedure that ignores its environment
;; argument and just returns the expression:

(define (analyze-self-evaluating exp)
  (lambda (env) exp))

;; ANALYZE-QUOTED
;; For a quoted expression, we can gain a little efficiency by
;; extracting the text of the quotation only once, in the analysis
;; phase, rather than in the execution phase.

(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env) qval)))

;; ANALYZE-VARIABLE
;; Looking up a variable value must still be done in the execution phase,
;; since this depends upon knowing the environment.

(define (analyze-variable exp)
  (lambda (env) (lookup-variable-value exp env)))

;; ANALYZE-ASSIGNMENT
;; Analyze-assignment also must defer actually setting the variable until
;; the execution, when the environment has been supplied. However, the
;; fact that the assignment-value expression can be
;; analyzed (recursively) during analysis is a major gain in
;; efficiency, because the assignment-value expression will now be
;; analyzed only once.

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env)
      (set-variable-value! var (vproc env) env)
      'ok)))

;; ANALYZE-DEFINITION
;; The same holds true for definitions.

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env)
      (define-variable! var (vproc env) env)
      'ok)))

;; ANALYZE-IF
;; For if expressions, we extract and analyze the predicate,
;; consequent, and alternative at analysis time.

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env)
      (if (true? (pproc env))
          (cproc env)
          (aproc env)))))

;; p275

;; ANALYZE-LAMBDA
;; Analyzing a lambda expression also achieves a major gain in
;; efficiency: We analyze the lambda body only once, even though
;; procedures resulting from evaluation of the lambda may be applied
;; many times.

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env) (make-procedure vars bproc env))))

;; ANALYZE-SEQUENCE
;; Analysis of a sequence of expressions (as in a begin or the body
;; of a lambda expression) is more involved. Each expression in the
;; sequence is analyzed, yielding an execution procedure. These
;; execution procedures are combined to produce an execution procedure
;; that takes an environment as argument and sequentially calls each
;; individual execution procedure with the environment as argument.
;;
;; what SEQUENTIALLY returns is exactly a proc which can be passed
;; to LOOP recursivly

(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))

;; ANALYZE-APPLICATION
;; To analyze an application, we analyze the operator and operands and
;; construct an execution procedure that calls the operator execution
;; procedure (to obtain the actual procedure to be applied) and the
;; operand execution procedures (to obtain the actual arguments). We
;; then pass these to execute-application, which is the analog of
;; apply in section 4.1.1. Execute-application differs from apply in
;; that the procedure body for a compound procedure has already been
;; analyzed, so there is no need to do further analysis. Instead, we
;; just call the execution procedure for the body on the extended
;; environment.

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env)
      (execute-application (fproc env)
                           (map (lambda (aproc) (aproc env))
                                aprocs)))))
(define (execute-application proc args)
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure proc args))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              args
                              (procedure-environment proc))))
        (else
         (error
          "Unknown procedure type -- EXECUTE-APPLICATION"
          proc))))

;; the mimic interpretator for the optimized EVAL-OPT
;; ATTENTION!!! the global environment is 'the-global-environment-opt'
(define (opt-driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval-opt input the-global-environment-opt)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
