;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.40
;;
;; In the multiple dwelling problem, how many sets of assignments are
;; there of people to floors, both before and after the requirement
;; that floor assignments be distinct? It is very inefficient to
;; generate all possible assignments of people to floors and then
;; leave it to backtracking to eliminate them. For example, most of
;; the restrictions depend on only one or two of the person-floor
;; variables, and can thus be imposed before floors have been selected
;; for all the people. Write and demonstrate a much more efficient
;; nondeterministic procedure that solves this problem based upon
;; generating only those possibilities that are not already ruled out
;; by previous restrictions. (Hint: This will require a nest of let
;; expressions.)
;;
;; =============================================================================


;; define the original multiple-swelling procedure
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
              (require (not (= (abs (- Smith fletcher)) 1)))
              (require (not (= (abs (- fletcher cooper)) 1)))
              (list (list 'baker baker)
                    (list 'cooper cooper)
                    (list 'fletcher fletcher)
                    (list 'miller miller)
                    (list 'smith smith))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the optimized multiple-swelling procedure
(ambeval '(define (multiple-dwelling-opt)
            (let ((baker (amb 1 2 3 4 5)))
               (require (not (= baker 5)))
              (let ((cooper (amb 1 2 3 4 5)))
                (require (not (= cooper 1)))
                (require (not (member cooper (list baker))))
                (let ((fletcher (amb 1 2 3 4 5)))
                  (require (not (= fletcher 5)))
                  (require (not (= fletcher 1)))
                  (require (not (member fletcher (list baker cooper))))
                  (let ((miller (amb 1 2 3 4 5)))
                    (require (> miller cooper))
                    (require (not (member miller (list baker cooper fletcher))))
                    (let ((smith (amb 1 2 3 4 5)))
                      (require (not (= (abs (- Smith fletcher)) 1)))
                      (require (not (= (abs (- fletcher cooper)) 1)))
                      (require (not
                                (member smith (list baker cooper fletcher miller))))
                      (list (list 'baker baker)
                            (list 'cooper cooper)
                            (list 'fletcher fletcher)
                            (list 'miller miller)
                            (list 'smith smith))))))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))



