;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-21
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.16

;; load all the original necessary procedures in the text book
(load "chpt-4-1.scm")

;; load modified EVAL procedure and let expression handles
(load "ex-4-06.scm")

;; load handle of internal defines
(load "ex-4-16.scm")

;; define the global environment
(define the-global-environment (setup-environment))

;; (define (test x)
;;   (grow (identity x))
;;   (define (identity x) x)
;;   (define (grow x) (cons x x)))

(eval '(define (test x)
         (grow (identity x))
         (define (identity x) x)
         (define (grow x) (cons x x)))
      the-global-environment)

;; test the following let expression
;; (test 1)
(newline)
(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; TYPE : (test 1)")
(newline)
(display ";;; you should see : Unbound variable identity -_-!")
(newline)
(display ";;; This is because the internal defines' scope are NOT ")
(newline)
(display ";;; the entire procedure body")
(newline)
(newline)
(display ";;; Now enter the source file and uncomment the line 17, which ")
(newline)
(display ";;; means the phrase (load \"ex-4-16.scm\") and redo the test")
(newline)
(display ";;; Then you should see : (1 . 1)")
(newline)
(display ";;; OR vice versa")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the mimic interpretator
(driver-loop)

