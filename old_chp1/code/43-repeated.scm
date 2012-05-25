;;; 43-repeated.scm

(define (repeated f n)
    (if (= n 1)
        f
        (lambda (x)
            (let ((fs (repeated f (- n 1))))
                (f (fs x))))))

; 无 let 版本
;
; (define (repeated f n)
;    (if (= n 1)
;        f
;        (lambda (x)
;            (f ((repeated f (- n 1)) x)))))
