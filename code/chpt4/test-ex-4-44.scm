;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-04
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-44

;; load ambeval analysis and interpretator
(load "chpt-4-3.scm")

;; add primitive operators
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'not not)
        (list 'equal? equal?)
        (list 'length length)
        (list '= =)
        (list '+ +)
        (list '- -)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define the require procedure
(ambeval '(define (require p) (if p 'ok (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(load "ex-4-44.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (eight-queens)")
(newline)
(display ";;; then type 'try-again to find  more solution")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
