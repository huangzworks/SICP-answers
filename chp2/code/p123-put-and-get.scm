;;; p123-put-and-get.scm

(load "p186-make-table.scm")

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
