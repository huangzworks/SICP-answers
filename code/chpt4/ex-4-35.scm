;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-02
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.35
;;
;; Write a procedure an-integer-between that returns an integer
;; between two given bounds. This can be used to implement a procedure
;; that finds Pythagorean triples, i.e., triples of integers (i,j,k)
;; between the given bounds such that i < j and i2 + j2 = k2, as
;; follows:
;;
;; (define (a-pythagorean-triple-between low high)
;;   (let ((i (an-integer-between low high)))
;;    (let ((j (an-integer-between i high)))
;;     (let ((k (an-integer-between j high)))
;;       (require (= (+ (* i i) (* j j)) (* k k)))
;;       (list i j k)))))
;;
;; =============================================================================


;; procesure AN-INTEGER-BETWEEN
;; (define (an-integer-between min max)
;;   (require (or (= min max )(< min max)))
;;   (amb min (an-integer-between (+ min 1) max)))

