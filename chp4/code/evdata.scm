;;;EVDATA.SCM
;;; Chapter 4 Evaluator data structures and driver loop

;;; The Read-Eval-Print Loop for the evaluators


(define (eval-loop)
  (newline)
  (let ((result
	 (force-it
          (current-evaluator
           (prompt-for-command-expression current-prompt)
           the-global-environment))))
    (newline)
    (display current-value-label)
    (pp (make-printable result))
    (eval-loop)))


;;; Since the environment is generally a circular list which will print forever,
;;; we use MAKE-PRINTABLE to turn circular list structures into lists

(define (make-printable object)
  (let ((visited '()))
    (define (mk-pble object)
      (if (and (pair? object) (not (eq? object *lazythunk*)))
          (let ((previous (memq object visited)))
            (if previous
                (string->symbol
                 (string-append
                 "revisited["
                 (number->string (length previous))
                 "]"))
                (begin
                  (set! visited (cons object visited))
                  (cons (mk-pble (car object))
                        (mk-pble (cdr object))))))
          object))
    (mk-pble object)))


(define current-evaluator 'uninitialized)
(define current-prompt 'uninitialized)
(define current-value-label 'uninitialized)

;;; Data Structures

(define (true? x) (not (eq? x #f)))

(define (false? x) (eq? x #f))

(define the-unspecified-value (list 'the-unspecified-value))

;;; Primitive procedures are inherited from Scheme.

(define primitive-procedure? procedure?)
(define apply-primitive-procedure apply)

;;; Compound procedures

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? exp)
  (tagged-list? exp 'procedure))

(define (procedure-parameters p) (list-ref p 1))
(define (procedure-body p) (list-ref p 2))
(define (procedure-environment p) (list-ref p 3))


;;; An ENVIRONMENT is a list of FRAMES.
;;; Each frame is a cons-pair consisting of a
;;; list of variables and a list of values.

(define the-global-environment 'uninitialized)
(define the-empty-environment '())

(define (extend-environment variables values base-environment)
  (if (= (length variables) (length values))
      (cons (cons variables values) base-environment)
      (if (< (length variables) (length values))
          (error "Too many arguments supplied" variables values)
          (error "Too few arguments supplied" variables values))))


;;; Initialize the environment

(define (init-env)
  (set! the-global-environment
	(extend-environment '() '() the-empty-environment))
  (set! scheme-variable-cache '())) ;This cache is an optimization in the
                                    ;implementation of LOOKUP-SCHEME-VALUE

;;; The environment is set up here to hook into Scheme along the lines
;;; of exercise 4.14.

(define (lookup-variable-value var env)
  (define (parent-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
	     (parent-loop (cdr env)))
	    ((eq? var (car vars))
	     (car vals))
	    (else
	     (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
	(lookup-scheme-value var)
	(scan (caar env) (cdar env))))
  (parent-loop env))


(define (set-variable-value! var val env)
  (define (parent-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
	     (parent-loop (cdr env)))
	    ((eq? var (car vars))
	     (set-car! vals val)
	     the-unspecified-value)
	    (else
	     (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
	(error "Unbound variable -- SET!" var)
	(scan (caar env) (cdar env))))
  (parent-loop env))


(define (define-variable! var val env)
  (define (scan vars vals)
    (cond ((null? vars)
	   (set-car! (car env) (cons var (caar env)))
	   (set-cdr! (car env) (cons val (cdar env))))
	  ((eq? var (car vars))
	   (set-car! vals val)
	   the-unspecified-value)
	  (else
	   (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (error "Unbound variable -- DEFINE" var) ;should not happen.
      (scan (caar env) (cdar env))))


;;; Procedures handling lazy parameter declarations

(define (force-all-args aprocs env)
  (map (lambda (aproc) (force-it (aproc env)))
       aprocs))

(define (process-arg-procs params aprocs env)
  (map (lambda (param aproc)
         (cond ((variable? param) (aproc env))
               ((lazy? param) (delay-it aproc env))
               ((memo? param) (delay-it-memo aproc env))
               (else (error "Unknown declaration" param))))
       params
       aprocs))


;;; Delayed evaluation structures

(define (delay-it proc env)
  (cons *lazythunk*
        (lambda () (proc env))))

(define (delay-it-memo proc env)
  (let ((value *unforced*))
    (cons *lazythunk*
          (lambda ()
            (if (eq? value *unforced*)
                (begin (set! value (proc env))
                       (set! proc '())
                       (set! env '())))
            value))))

(define (force-it obj)
  (if (and (pair? obj) (eq? (car obj) *lazythunk*))
      (force-it ((cdr obj)))
      obj))

(define *unforced* (list '*unforced*))
(define *lazythunk* (list '*lazythunk*))

;;;MISCELLANEOUS SYSTEM PROCEDURES---CAN BE IGNORED

;;; We speed up Scheme variable lookup by keeping
;;; a cache of the variables that we actually look up.

(define lexical-unreferenceable?
  (make-primitive-procedure 'lexical-unreferenceable?))

(define lexical-reference
  (make-primitive-procedure 'lexical-reference))

(define scheme-variable-cache '())

(define (lookup-scheme-value var)
  (let ((vcell (assq var scheme-variable-cache)))
    (cond (vcell (cdr vcell))
	  ((not (lexical-unreferenceable? user-initial-environment var))
	   (let ((val (lexical-reference user-initial-environment var)))
	     (set! scheme-variable-cache
		   (cons (cons var val) scheme-variable-cache))
	     val))
	  (else
	   (error "Unbound variable" var)))))

;;; The following commands keep the Scheme printer from going into
;;; an infinite loop when printing circular list structures such
;;; as environments.

(set! *unparser-list-depth-limit* 7)
(set! *unparser-list-breadth-limit* 10)
