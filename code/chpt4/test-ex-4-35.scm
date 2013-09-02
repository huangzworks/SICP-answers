;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-02
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-35

;; load ambeval analysis and interpretator
(load "chpt-4-3.scm")

;; add primitive operator 'or' '+' '<' '*' and '='
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '* *)
        (list '= =)
        (list '+ +)
        (list '< <)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define the require procedure
(ambeval '(define (require p) (if p 'ok (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the an-integer-between procedure
(ambeval '(define (an-integer-between min max)
            (require (< min max))
            (amb min (an-integer-between (+ min 1) max)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the a-pythagorean-triple-between procedure
(ambeval '(define (a-pythagorean-triple-between low high)
            (let ((i (an-integer-between low high)))
              (let ((j (an-integer-between i high)))
                (let ((k (an-integer-between j high)))
                  (require (= (+ (* i i) (* j j)) (* k k)))
                  (cons i (cons j (cons k '())))))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (a-pythagorean-triple-between min max)")
(newline)
(display ";;; you should see a pythagorean triple between min and max")
(newline)
(display ";;; where 'min' and 'max' are up to you")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
