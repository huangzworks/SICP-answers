;;; 12-iter-pascal.scm

(define (pascal row col)
    (/ (factorial row)
       (* (factorial col)
          (factorial (- row col)))))

;; factorial 的定义来自书本 1.2.1 节

(define (factorial n)
    (fact-iter 1 1 n))

(define (fact-iter result counter max-counter)
    (if (> counter max-counter)
        result
        (fact-iter (* counter result)
                   (+ counter 1)
                   max-counter)))
