;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-21
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.16
;;
;; The procedure
;;
;; (lambda <vars>
;;  (define u <e1>)
;;  (define v <e2>)
;;  <e3>)
;;
;; would be transformed into
;;
;; (lambda <vars>
;;   (let ((u '*unassigned*)
;;        (v '*unassigned*))
;;    (set! u <e1>)
;;    (set! v <e2>)
;;    <e3>))
;;
;; In this exercise we implement the method just described for
;; interpreting internal definitions. We assume that the evaluator
;; supports let (see exercise 4.6).
;;
;; a.  Change lookup-variable-value (section 4.1.3) to signal an error
;; if the value it finds is the symbol *unassigned*.
;;
;; b.  Write a procedure scan-out-defines that takes a procedure body and
;; returns an equivalent one that has no internal definitions, by
;; making the transformation described above.
;;
;; c.  Install scan-out-defines in the interpreter, either in
;; make-procedure or in procedure-body (see section 4.1.3). Which
;; place is better? Why?
;;
;; =============================================================================


;; a.
;; modification of the lookup-variable-value procedure
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? '*unassigned* (car vals))
                 (error "Unassigned variable" (car vars))
                 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;; b.
;;
(define (scan-out-defines procedure-body)
  (define (extractor-rest-exp body)
    (if (null? body)
        '()
        (if (tagged-list? (car body) 'define)
            (extractor-rest-exp (cdr body))
            (cons (car body) (extractor-rest-exp (cdr body))))))
  (define (extractor-internal-defs body)
    (if (null? body)
        '()
        (if (tagged-list? (car body) 'define)
            (cons (list (definition-variable (car body)) ''*unassigned*)
                  (extractor-internal-defs (cdr body)))
            (extractor-internal-defs (cdr body)))))
  (define (extractor-set-exps body)
    (if (null? body)
        '()
        (if (tagged-list? (car body) 'define)
            (cons (list 'set!
                        (definition-variable (car body))
                        (definition-value (car body)))
                  (extractor-set-exps (cdr body)))
            (extractor-set-exps (cdr body)))))
  (let ((internal-defs (extractor-internal-defs procedure-body)))
    (if (null? internal-defs)
        procedure-body
        (list (make-let (extractor-internal-defs procedure-body)
                        (append (extractor-set-exps procedure-body)
                                (extractor-rest-exp procedure-body)))))))

;; c.
;; Install scan-out-defines in make-procedure:
;; a little more storage but faster, only run once the scan-out-defines
;; Install scan-out-defines in procedure-body:
;; less storage but run for every call the scan-out-defines
;; In my opinion, Install in make-procedure should be better

(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))

