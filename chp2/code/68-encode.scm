;;; 68-encode.scm

(load "68-encode-symbol.scm")

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))
