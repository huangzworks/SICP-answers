;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Test Exercise 4.2

;; load all the original necessary procedures in the text book

(load "chpt-4-1.scm")

;; load the modified EVAL procedure and extractors of the procedure expressions
;  which means 'operator' and 'operands'

(load "ex-4-02.scm")

;; define the global environment

(define the-global-environment (setup-environment))

;; define a variable

(eval
'(define x 3)
the-global-environment
)

;; define the append procedure
;; you need to pay attention when you write the definition for a function,
;  every invocation of a procedure, you must add 'call to call it

(eval
'(define (append x y)
   (if (call null? x)
       y
       (call cons (call car x)
             (call append (call cdr x) y))))
the-global-environment
)

(display ";;; ******************** TEST ****************************************")
;; test expression (define x 3)

(newline)
(display ";;; type: (eval 'x the-global-environment)")
(newline)
(display ";;; then you should see : 3")
(newline)

;; verify the EVAL procedure works with the new syntax style (with 'call')

(newline)
(display ";;;  TYPE: ")
(newline)
(display ";;; (eval '(call append '(a b c) '(d e f)) the-global-environment)")
(newline)
(display ";;; then you should see : (a b c d e f)")
(newline)
(display ";;; ******************** TEST ****************************************")

