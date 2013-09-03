;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-43

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
        (list 'eq? eq?)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define the require procedure
(ambeval '(define (require p) (if p 'ok (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; load the procedure Lorna-s-father
(load "ex-4-43.scm")

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (who-s-father-is-who)")
(newline)
(display ";;; you should find out Lorna's father is Colonel Dowing")
(newline)
(display ";;; type try-again, there is no more solution")
(newline)
(display ";;; Now type (who-s-father-is-who-multiple) and try-again")
(newline)
(display ";;; to find all possiblities if we don't know Mary Ann's last name")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
