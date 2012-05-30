;;; 20-same-parity.scm

(define (same-parity sample . others)
    (filter (if (even? sample)
                even?
                odd?)
            (cons sample others)))      ; 别忘了 sample 也要包含在列表内
