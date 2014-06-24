;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-18
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.13
;;
;; Scheme allows us to create new bindings for variables by means of
;; define, but provides no way to get rid of bindings. Implement for
;; the evaluator a special form make-unbound! that removes the binding
;; of a given symbol from the environment in which the make-unbound!
;; expression is evaluated. This problem is not completely
;; specified. For example, should we remove only the binding in the
;; first frame of the environment? Complete the specification and
;; justify any choices you make.
;;
;; =============================================================================
