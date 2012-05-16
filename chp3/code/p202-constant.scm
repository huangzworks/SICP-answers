;;; p202-constant.scm

(define (constant value connector)
    (define (me request)
        (error "Unknown request -- CONSTANT" request))
    (connect connector me)
    (set-value! connector value me)
    me)
