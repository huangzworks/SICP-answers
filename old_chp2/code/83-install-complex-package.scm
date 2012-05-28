;;; 83-install-complex-package.scm

(load "p123-put-and-get.scm")
(load "p119-attach-tag-and-type-tag-and-contents.scm")

(define (install-complex-package)
    
    (define (tag x)
        (attach-tag 'complex x))

    (put 'make 'complex
        (lambda (x y)
            (tag (make-rectangular x y))))

'done)

(define (make-complex x y)
    ((get 'make 'complex) x y))
