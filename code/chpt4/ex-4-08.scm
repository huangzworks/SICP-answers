;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-11
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.8
;; ``Named let'' is a variant of let that has the form
;
;  (let <var> <bindings> <body>)
;
;;  The <bindings> and <body> are just as in ordinary let, except that <var> 
;  is bound within <body> to a procedure whose body is <body> and whose 
;  parameters are the variables in the <bindings>. Thus, one can repeatedly 
;  execute the <body> by invoking the procedure named <var>. For example, 
;  the iterative Fibonacci procedure (section 1.2.2) can be rewritten using 
;  named let as follows:
;
;  (define (fib n)
;    (let fib-iter ((a 1)
;                   (b 0)
;                   (count n))
;      (if (= count 0)
;          b
;          (fib-iter (+ a b) a (- count 1)))))
;
;; Modify let->combination of exercise 4.6 to also support named let.
