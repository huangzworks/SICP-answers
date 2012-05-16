;;; p201-constraint-interface.scm

(define (inform-about-value constraint)
    (constraint 'I-have-a-value))

(define (inform-about-no-value constraint)
    (constraint 'I-lost-my-value))
