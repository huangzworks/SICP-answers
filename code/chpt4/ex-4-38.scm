;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.38
;;
;; Modify the multiple-dwelling procedure to omit the requirement that
;; Smith and Fletcher do not live on adjacent floors. How many
;; solutions are there to this modified puzzle?
;;
;; (define (multiple-dwelling)
;;   (let ((baker (amb 1 2 3 4 5))
;;         (cooper (amb 1 2 3 4 5))
;;         (fletcher (amb 1 2 3 4 5))
;;         (miller (amb 1 2 3 4 5))
;;         (smith (amb 1 2 3 4 5)))
;;     (require
;;      (distinct? (list baker cooper fletcher miller smith)))
;;     (require (not (= baker 5)))
;;     (require (not (= cooper 1)))
;;     (require (not (= fletcher 5)))
;;     (require (not (= fletcher 1)))
;;     (require (> miller cooper))
;;     (require (not (= (abs (- smith fletcher)) 1)))
;;     (require (not (= (abs (- fletcher cooper)) 1)))
;;     (list (list 'baker baker)
;;           (list 'cooper cooper)
;;           (list 'fletcher fletcher)
;;           (list 'miller miller)
;;           (list 'smith smith))))
;;
;; =============================================================================

;; define the absolute procedure for use in multiple-dwelling
(ambeval '(define (abs number)
            (if (< number 0)
                (- number)
                number))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the member procedure for use in distinct?
(ambeval '(define (member item list)
            (if (null? list)
                false
                (if (equal? item (car list))
                    true
                    (member item (cdr list)))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the distinct? procedure for use in multiple-dwelling
(ambeval '(define (distinct? items)
            (cond ((null? items) true)
                  ((null? (cdr items)) true)
                  ((member (car items) (cdr items)) false)
                  (else (distinct? (cdr items)))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (multiple-dwelling)
            (let ((baker (amb 1 2 3 4 5))
                  (cooper (amb 1 2 3 4 5))
                  (fletcher (amb 1 2 3 4 5))
                  (miller (amb 1 2 3 4 5))
                  (smith (amb 1 2 3 4 5)))
              (require
               (distinct? (list baker cooper fletcher miller smith)))
              (require (not (= baker 5)))
              (require (not (= cooper 1)))
              (require (not (= fletcher 5)))
              (require (not (= fletcher 1)))
              (require (> miller cooper))
;;            (require (not (= (abs (- Smith fletcher)) 1)))   ; comment this line
              (require (not (= (abs (- fletcher cooper)) 1)))
              (list (list 'baker baker)
                    (list 'cooper cooper)
                    (list 'fletcher fletcher)
                    (list 'miller miller)
                    (list 'smith smith))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
