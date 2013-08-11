p;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.4
;; Recall the definitions of the special forms and and or from chapter 1:
;
;; and: The expressions are evaluated from left to right. If any expression 
;       evaluates to false, false is returned; any remaining expressions are 
;       not evaluated. If all the expressions evaluate to true values, the 
;       value of the last expression is returned. If there are no expressions 
;       then true is returned.
;
;; or: The expressions are evaluated from left to right. If any expression 
;      evaluates to a true value, that value is returned; any remaining 
;      expressions are not evaluated. If all expressions evaluate to false, 
;      or if there are no expressions, then false is returned.
;
;; Install and and or as new special forms for the evaluator by defining 
;  appropriate syntax procedures and evaluation procedures eval-and and 
;  eval-or. Alternatively, show how to implement and and or as derived 
;  expressions.
