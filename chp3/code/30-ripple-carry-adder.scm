;;; 30-ripple-carry-adder.scm

(define (ripple-carry-adder list-A list-B list-S C)
    (define (iter A B S value-of-c)
        (if (and (null? A) (null? B) (null? S))
            'ok
            (let ((Ak (car A))
                  (Bk (car B))
                  (Sk (car S))
                  (remain-A (cdr A))
                  (remain-B (cdr B))
                  (remain-S (cdr S))
                  (Ck (make-wire)))
                (set-signal! Ck value-of-c)
                (full-adder Ak Bk Ck Sk C)
                (iter remain-A remain-B remain-S (get-signal C)))))
    (iter list-A list-B list-S (get-signal C)))
