;;; p113-adjoin-set.scm

(load "p112-huffman.scm")

(define (adjoin-set x set)
    (cond ((null? set)
            (list x))
          ((< (weight x) (weight (car set)))
            (cons x set))
          (else
            (cons (car set)
                  (adjoin-set x (cdr set))))))
