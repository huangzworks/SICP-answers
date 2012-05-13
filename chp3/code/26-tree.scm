;;; 26-tree.scm

; constructor

(define (make-tree key value left-branch right-branch)
    (list key value left-branch right-branch))

; selector

(define (tree-key tree)
    (car tree))

(define (tree-value tree)
    (cadr tree))

(define (tree-left-branch tree)
    (caddr tree))

(define (tree-right-branch tree)
    (cadddr tree))

(define (tree-empty? tree)
    (null? tree))

; setter

(define (tree-set-key! new-key tree)
    (set-car! tree new-key))

(define (tree-set-value! new-value tree)
    (set-car! (cdr tree) new-value))

(define (tree-set-left-branch! new-left-branch tree)
    (set-car! (cddr tree) new-left-branch))

(define (tree-set-right-branch! new-right-branch tree)
    (set-car! (cdddr tree) new-right-branch))

; operator

(define (tree-insert! tree given-key value compare)
    (if (tree-empty? tree)
        (make-tree given-key value '() '())
        (let ((compare-result (compare given-key (tree-key tree))))
            (cond ((= 0 compare-result)
                    (tree-set-value! value tree)
                    tree)
                  ((= 1 compare-result)
                    (tree-set-right-branch!
                        (tree-insert! (tree-right-branch tree) given-key value compare)
                        tree)
                    tree)
                  ((= -1 compare-result)
                    (tree-set-left-branch!
                        (tree-insert! (tree-left-branch tree) given-key value compare)
                        tree)
                    tree)))))

(define (tree-search tree given-key compare)
    (if (tree-empty? tree)
        '()
        (let ((compare-result (compare given-key (tree-key tree))))
            (cond ((= 0 compare-result)
                    tree)
                  ((= 1 compare-result)
                    (tree-search (tree-right-branch tree) given-key compare))
                  ((= -1 compare-result)
                    (tree-search (tree-left-branch tree) given-key compare))))))

; comparer

(define (compare-string x y)
    (cond ((string=? x y)
            0)
          ((string>? x y)
            1)
          ((string<? x y)
            -1)))

(define (compare-symbol x y)
    (compare-string (symbol->string x)
                    (symbol->string y)))

(define (compare-number x y)
    (cond ((= x y)
            0)
          ((> x y)
            1)
          ((< x y)
            -1)))
