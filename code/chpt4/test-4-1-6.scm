;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test chpt 4-1-1 to chpt 4-1-6

(load "Chpt-4-1.scm")

(define the-global-environment (setup-environment))

(eval
'(define (append x y)
   (if (null? x)
       y
       (cons (car x)
             (append (cdr x) y))))
the-global-environment
)

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; you should see : (a b c d e f)")
(newline)
(display ";;; ******************** TEST ****************************************")

(eval
'(append '(a b c) '(d e f))
the-global-environment
)