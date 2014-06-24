;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-02
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.37
;;
;; Ben Bitdiddle claims that the following method for generating
;; Pythagorean triples is more efficient than the one in exercise
;; 4.35. Is he correct? (Hint: Consider the number of possibilities
;; that must be explored.)
;;
;; (define (a-pythagorean-triple-between low high)
;;   (let ((i (an-integer-between low high))
;;         (hsq (* high high)))
;;     (let ((j (an-integer-between i high)))
;;       (let ((ksq (+ (* i i) (* j j))))
;;         (require (>= hsq ksq))
;;         (let ((k (sqrt ksq)))
;;           (require (integer? k))
;;           (list i j k))))))
;;
;; =============================================================================


;; ANSWER: YES, it could be more efficient in term of possibilities, since
           for k, there is at most 1 possibility while in ex 4.35, there are
           high-j possibilities.
