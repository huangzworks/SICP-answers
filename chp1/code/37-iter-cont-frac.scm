;;; 37-iter-cont-frac.scm

(define (cont-frac N D k)

    (define (iter i result)
        (if (= i 0)
            result
            (iter (- i 1)
                  (/ (N i)
                     (+ (D i) result)))))

    (iter (- k 1)
          (/ (N k) (D k))))
