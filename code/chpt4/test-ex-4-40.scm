;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-40

;; load ambeval analysis and interpretator
(load "chpt-4-3.scm")

;; add primitive operators
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'not not)
        (list 'list list)
        (list 'equal? equal?)
        (list '* *)
        (list '= =)
        (list '+ +)
        (list '- -)
        (list '> >)
        (list '< <)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define the require procedure
(ambeval '(define (require p) (if p 'ok (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; load the necessary procedures to define multiple-dwelling-opt
(load "ex-4-38.scm")

;; load the multiple-dwelling definition and its optimized version
(load "ex-4-40.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (multiple-dwelling)")
(newline)
(display ";;; then type (multiple-dwelling-opt)")
(newline)
(display ";;; you find the same answer but much faster by the optimized version")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
