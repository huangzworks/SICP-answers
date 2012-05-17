;;; 36.scm

(define make-connector

    ((lambda (value informant constraints)

        (define set-my-value
            (lambda (newval setter)
                (cond 
                    ((not (has-value? me))
                        (set! value newval)
                        (set! informant setter)
                        (for-each-except setter
                                         inform-about-value
                                         constraints))
                    ((not (= value newval))
                        (error "Contradiction" (list value newval)))
                    (else 'ignored))))

        (define forget-my-value
            (lambda (retractor)
                (if (eq? retractor informant)
                    (begin
                        (set! informant #f)
                        (for-each-except retractor
                                         inform-about-no-value
                                         constraints))
                    'ignored)))

        (define connect
            (lambda (new-constraint)
                (if (not (memq new-constraint constraints))
                    (set!
                        constraints
                        (cons new-constraint constraints)))
                (if (has-value? me)
                    (inform-about-value new-constraint))
                'done))

        (define me
            (lambda (request)   
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
                        (error "Unknown operation -- CONNECTOR" request)))))

    me)

     #f #f '()))

(define for-each-except
    (lambda (exception procedure list)

        (define loop
            (lambda (items)
                (cond
                    ((null? items)
                        'done)
                    ((eq? (car items) exception)
                        (loop (cdr items)))
                    (else
                        (procedure (car items))
                        (loop (cdr items))))))

        (loop list)))

(define inform-about-value
    (lambda (constraint)
        (constraint 'I-have-a-value)))

(define set-value!
    (lambda (connecotr new-value informant)
        ((connecotr 'set-value!) new-value informant)))
