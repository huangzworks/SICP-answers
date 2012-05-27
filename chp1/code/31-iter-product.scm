;;; 31-iter-product.scm

(define (product term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (+ a 1)
                  (* (term a) result))))
    (iter a 1))
