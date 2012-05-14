;;; 30-ripple-carry-adder.scm

(define (ripple-carry-adder A B S C)
    (if (and (null? A) (null? B) (null? S))
        (get-signal C)
        (let ((Ak (car A))
              (Bk (car B))
              (Sk (car S))
              (remain-A (cdr A))
              (remain-B (cdr B))
              (remain-S (cdr S)))
            (full-adder Ak Bk C Sk C)
            (ripple-carry-adder remain-A remain-B remain-S C))))
