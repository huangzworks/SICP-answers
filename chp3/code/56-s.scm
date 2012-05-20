;;; 56-s.scm

(load "p229-scale-stream.scm")
(load "56-merge.scm")

(define s (cons-stream 1 
                       (merge (scale-stream s 2)
                              (merge (scale-stream s 3)
                                     (scale-stream s 5)))))
