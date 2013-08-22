;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.5

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load the modified EVAL procedure and extractors of the procedure expressions
;; which means 'operator' and 'operands'
(load "ex-4-05.scm")

;; add eq? as primitive procedure
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'eq? eq?)
        (list 'null? null?)
  ))

;; define the global environment
(define the-global-environment (setup-environment))

;; add the 'assoc' procedure to the global environment for test use
(eval '(define (assoc match a-list)
         (if (null? a-list)
             false
             (if (eq? match (caar a-list))
                 (car a-list)
                 (assoc match (cdr a-list)))))
      the-global-environment)

;; add 'cadr' 'caar' and 'cadar' procedures to the global environment
;; because they are used in the 'assoc' procedure
(eval '(define (cadr exp) (car (cdr exp))) the-global-environment)
(eval '(define (caar exp) (car (car exp))) the-global-environment)
(eval '(define (cadar exp) (car (cdr (car exp)))) the-global-environment)

;; test the following expression
;; (cond ((assoc 'b '((a 1) (b 2))) => cadr)
;;       (else false))
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE : ")
(newline)
(display ";;; (cond ((assoc 'b '((a 1) (b 2))) => cadr) (else false))")
(newline)
(display ";;; you should see : 2")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(driver-loop)
