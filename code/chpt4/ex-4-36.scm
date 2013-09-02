;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-02
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.36
;;
;; Exercise 3.69 discussed how to generate the stream of all
;; Pythagorean triples, with no upper bound on the size of the
;; integers to be searched. Explain why simply replacing
;; an-integer-between by an-integer-starting-from in the procedure in
;; exercise 4.35 is not an adequate way to generate arbitrary
;; Pythagorean triples. Write a procedure that actually will
;; accomplish this. (That is, write a procedure for which repeatedly
;; typing try-again would in principle eventually generate all
;; Pythagorean triples.)
;;
;; =============================================================================


;; ANSWER: because an-integer-starting-from is a procedure that would
;;         never fail.

;; a procedure a-pythagorean-triple that eventually generate all
;; Pythagorean triples in principle.
;; (define (a-pythagorean-triple)
;;   (let ((k (an-integer-starting-from 1)))
;;     (let ((i (an-integer-between 1 k)))
;;       (let ((j (an-integer-between i k)))
;;         (require (= (+ (* i i) (* j j)) (* k k)))
;;         (cons i (cons j (cons k '())))))))
