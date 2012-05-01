;;; 36-accumulate-n.scm

(load "p78-accumulate.scm")
(load "36-car-n.scm")
(load "36-cdr-n.scm")

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (car-n seqs))
              (accumulate-n op init (cdr-n seqs)))))
