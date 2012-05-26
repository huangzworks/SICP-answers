;;; 18.scm

(load "17-double-and-halve.scm")

(define (multi a b)
    (multi-iter a b 0))

(define (multi-iter a b product)
    (cond ((= b 0)
            product)
          ((even? b)
            (multi-iter (double a)
                        (halve b)
                        product))
          ((odd? b)
            (multi-iter a
                        (- b 1)
                        (+ a product)))))
