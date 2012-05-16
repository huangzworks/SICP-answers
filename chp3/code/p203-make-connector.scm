;;; p203-make-connector.scm

(define (make-connector)
    (let ((value #f)
          (informant #f)
          (constraints '()))
        (define (set-my-value newval setter)
            (cond 
                ((not (has-value? me))
                    (set! value newval)
                    (set! informant setter)
                    (for-each-except setter
                                     inform-about-value
                                     constraints))
                ((not (= value newval))
                    (error "Contradiction" (list value newval)))
                (else 'ignored)))
        (define (forget-my-value retractor)
            (if (eq? retractor informant)
                (begin 
                    (set! informant #f)
                    (for-each-except retractor
                                     inform-about-no-value
                                     constraints))
                'ignored))
        (define (connect new-constraint)
            (if (not (memq new-constraint constraints))
                (set! 
                    constraints
                    (cons new-constraint constraints)))
            (if (has-value? me)
                (inform-about-value new-constraint))
            'done)
        (define (me request)
            (cond
                ((eq? request 'has-value?)
                    (if informant #t #f))
                ((eq? request 'value)
                    value)
                ((eq? request 'set-value!)
                    set-my-value)
                ((eq? request 'forget)
                    forget-my-value)
                ((eq? request 'connect)
                    connect)
                (else
                    (error "Unknown operation -- CONNECTOR" request))))
        me))

(define (for-each-except exception procedure list)
    (define (loop items)
        (cond
            ((null? items)
                'done)
            ((eq? (car items) exception)
                (loop (cdr items)))
            (else
                (procedure (car items))
                (loop (cdr items)))))
    (loop list))

; interface

(define (has-value? connecotr)
    (connecotr 'has-value?))

(define (get-value connecotr)
    (connecotr 'value))

(define (set-value! connecotr new-value informant)
    ((connecotr 'set-value!) new-value informant))

(define (forget-value! connecotr retractor)
    ((connecotr 'forget) retractor))

(define (connect connecotr new-constraint)
    ((connecotr 'connect) new-constraint))
