;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-38

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

(load "ex-4-38.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (multiple-dwelling)")
(newline)
(display ";;; then type 'try-again until there is no more solution")
(newline)
(display ";;; finally we find out that there is in total 5 solutions")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
