;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.39
;;
;; Does the order of the restrictions in the multiple-dwelling
;; procedure affect the answer? Does it affect the time to find an
;; answer? If you think it matters, demonstrate a faster program
;; obtained from the given one by reordering the restrictions. If you
;; think it does not matter, argue your case.
;;
;; =============================================================================

;; ANSWER: The order of the restrictions do NOT affect the answer;
;;         but it MAY affect the time to find an answer since it may skip
;;         some require tests. However, the influence of the order of the
;;         restrictions is of little interest since it still has to check
;;         all the same possiblities in the same order.

;; We may check this by recording time
