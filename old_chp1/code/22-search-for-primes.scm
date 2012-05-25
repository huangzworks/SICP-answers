;;; 22-search-for-primes.scm

(load "22-continue-primes.scm")

(define (search-for-primes n)
    (let ((start-time (real-time-clock)))
        (continue-primes n 3)
        (- (real-time-clock) start-time)))
