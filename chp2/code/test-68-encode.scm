(load "test-manager/load.scm")
(load "p112-huffman.scm")
(load "p113-decode.scm")
(load "68-encode.scm")

(define t (make-code-tree (make-leaf 'A 4)
                          (make-code-tree 
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))

(define msg '(a d a b b c a))

(define-each-check
    
    (equal? (decode (encode msg t) t)
            msg)

)

(run-registered-tests)
