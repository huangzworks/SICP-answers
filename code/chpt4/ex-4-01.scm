;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.1
;;
;; Notice that we cannot tell whether the metacircular evaluator evaluates
;; operands from left to right or from right to left. Its evaluation order is
;; inherited from the underlying Lisp: If the arguments to cons in
;; list-of-values are evaluated from left to right, then list-of-values will
;; evaluate operands from left to right; and if the arguments to cons are
;; evaluated from right to left, then list-of-values will evaluate operands
;; from right to left.
;;
;; =============================================================================


;; Evaluation from left to right
(define (list-of-values exps env)
  (if (not-operands? exps)
      '()
      (let ((first-value (eval (first-operand exps) env)))
        (cons first-value
              (list-of-values (rest-operands exps) env)))))


;; Evaluation from right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((rest-values (list-of-values (rest-operands exps) env)))
        (cons (eval (first-operand exps) env)
              rest-values))))
