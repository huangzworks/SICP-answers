;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.8
;;
;; ``Named let'' is a variant of let that has the form
;;
;; (let <var> <bindings> <body>)
;;
;;  The <bindings> and <body> are just as in ordinary let, except that <var>
;; is bound within <body> to a procedure whose body is <body> and whose
;; parameters are the variables in the <bindings>. Thus, one can repeatedly
;; execute the <body> by invoking the procedure named <var>. For example,
;; the iterative Fibonacci procedure (section 1.2.2) can be rewritten using
;; named let as follows:
;;
;; (define (fib n)
;;   (let fib-iter ((a 1)
;;                  (b 0)
;;                  (count n))
;;     (if (= count 0)
;;         b
;;         (fib-iter (+ a b) a (- count 1)))))
;;
;; Modify let->combination of exercise 4.6 to also support named let.
;;
;; =============================================================================


;; load let utility, etc. in ex-4-06.scm
(load "ex-4-06.scm")

;; load make-let, etc. in ex-4-07.scm
(load "ex-4-07.scm")

;; test if it is a named let expression
(define (let-named? exp) (symbol? (cadr exp)))

;; let-named uitilites
(define (let-named-name exp) (cadr exp))
;; ATTENTION ! the binding could be '()
(define (let-named-parameters exp)
  (if (null? (caddr exp))
      '()
      (map car (caddr exp))))
(define (let-named-arguments exp)
  (if (null? (caddr exp))
      '()
      (map cadr (caddr exp))))
(define (let-named-body exp) (cdddr exp))

;; ATTENTION !!!!! the following modification do NOT work
;; (define (let->combination exp)
;;   (if (let-named? exp)
;;      (make-let (list (list (let-named-name exp)
;;                            (make-lambda (let-named-parameters exp)
;;                                         (let-named-body exp))))
;;                (list (cons (let-named-name exp)
;;                            (let-named-arguments exp))))
;;      (cons (make-lambda (let-parameters exp)
;;                         (let-body exp))
;;            (let-arguments exp))))

;; right modification of let->combination, must explicitly use define
(define (let->combination exp)
  (if (let-named? exp)
      (sequence->exp (list
                      (cons 'define
                            (cons (cons (let-named-name exp)
                                        (let-named-parameters exp))
                                  (let-named-body exp)))
                      (cons (let-named-name exp)
                            (let-named-arguments exp))))
      (cons (make-lambda (let-parameters exp)
                         (let-body exp))
            (let-arguments exp))))
