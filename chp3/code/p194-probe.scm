;;; p194-probe.scm

(define (probe name wire)
    (add-action! wire
                 (lambda ()        
                    (newline)
                    (display name)
                    (display " ")
                    (display (current-time the-agenda))
                    (display "  New-value = ")
                    (display (get-signal wire)))))
