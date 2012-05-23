;;; p234-make-tableau.scm

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))
