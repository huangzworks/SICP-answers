;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-02
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test ex-4-36

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
        (list '- -)
        (list '< <)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define the require procedure
(ambeval '(define (require p) (if p 'ok (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the a-pythagorean-triple procedure which would enventually
;; produce all Pthagorean triple in principle
(ambeval '(define (a-pythagorean-triple)
            (let ((k (an-integer-starting-from 1)))
              (let ((i (an-integer-between 1 k)))
              (let ((j (an-integer-between i k)))
                (require (= (+ (* i i) (* j j)) (* k k)))
                (cons i (cons j (cons k '())))))))
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

;; define the an-integer-starting-from procedure
(ambeval '(define (an-integer-starting-from n)
            (amb n (an-integer-starting-from (+ n 1))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(display ";;; ******************** TEST ****************************************")
(newline)
(display ";;; type (a-pythagorean-triple)")
(newline)
(display ";;; you should see a pythagorean triple")
(newline)
(display ";;; this procedure would in principle calculate all")
(newline)
(display ";;; Pythagorean triples if you keep typing try-again")
(newline)
(display ";;; ******************** TEST ****************************************")

;; run the amb eval
(driver-loop)
