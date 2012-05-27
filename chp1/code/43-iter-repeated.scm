;;; 43-iter-repeated.scm

(define (repeated f n)
    (define (iter i repeated-f)
        (if (= i 1)
            repeated-f
            (iter (- i 1)
                  (lambda (x)
                      (f (repeated-f x))))))
    (iter n f))
