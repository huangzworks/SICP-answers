;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;                   Chapter 4 Metalinguistic Abstraction
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;===============================================================================
;; 4.2 Variations on a Scheme -- Lazy Evaluation
;;===============================================================================

;;-------------------------------------------------------------------------------
;; 4.2.1  Normal Order and Applicative Order
;;-------------------------------------------------------------------------------

;;-------------------------------------------------------------------------------
;; 4.2.2  An Interpreter with Lazy Evaluation
;;-------------------------------------------------------------------------------
;; p279

;; In this section we will implement a normal-order language that is the
;; same as Scheme except that compound procedures are non-strict in
;; each argument. Primitive procedures will still be strict. It is not
;; difficult to modify the evaluator of section 4.1.1 so that the
;; language it interprets behaves this way. ALMOST ALL THE REQUIRED
;; CHANGES CENTER AROUND PROCEDURE APPLICATION.
;;
;; The basic idea is that, when applying a procedure, the interpreter
;; must determine which arguments are to be evaluated and which are to
;; be delayed. The delayed arguments are not evaluated, instead, they
;; are transformed into objects called thunks.34 The thunk must
;; contain the information required to produce the value of the
;; argument when it is needed, as if it had been evaluated at the time
;; of the application. Thus, the thunk must contain the argument
;; expression and the environment in which the procedure application
;; is being evaluated.
;;
;; The process of evaluating the expression in a thunk is called
;; forcing. In general, a thunk will be forced only when its value
;; is needed: when it is passed to a primitive procedure that will use
;; the value of the thunk, when it is the value of a predicate of a
;; conditional, and when it is the value of an operator that is about
;; to be applied as a procedure. One design choice we have available
;; is whether or not to memoize thunks, as we did with delayed objects
;; in section 3.5.1. With memoization, the first time a thunk is
;; forced, it stores the value that is computed. Subsequent forcings
;; simply return the stored value without repeating the
;; computation. We'll make our interpreter memoize, because this is
;; more efficient for many applications. There are tricky
;; considerations here, however.


;; MODIFYING THE EVALUATOR

;; The main difference between the lazy evaluator and the one in
;; section 4.1 is in the handling of procedure applications in eval
;; and apply.

((application? exp)
 (apply (actual-value (operator exp) env)
        (operands exp)
        env))

;; Whenever we need the actual value of an expression, we use

(define (actual-value exp env)
  (force-it (eval exp env)))

;; Our new version of apply is also almost the same as the version in
;; section 4.1.1. The difference is that eval has passed in
;; unevaluated operand expressions: For primitive procedures (which
;; are strict), we evaluate all the arguments before applying the
;; primitive, for compound procedures (which are non-strict) we delay
;; all the arguments before applying the procedure.

(define (new-apply procedure arguments env) ; remember we use new-apply as name
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))  ; changed
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           (list-of-delayed-args arguments env) ; changed
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))
