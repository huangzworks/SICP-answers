(load "test-manager/load.scm")
(load "p112-huffman.scm")
(load "p113-decode.scm")

(define t (make-code-tree (make-leaf 'A 4)
                          (make-code-tree 
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))

(define-each-check

    (equal? (decode '(0 1 1 0 0 1 0 1 0 1 1 1 0) t)
            '(a d a b b c a))

)

(run-registered-tests)
