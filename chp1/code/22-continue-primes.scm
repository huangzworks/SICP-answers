;;; 22-continue-primes.scm

(load "p33-prime.scm")
(load "22-next-odd.scm")

(define (continue-primes n count)
    (cond ((= count 0)
            (display "are primes."))
          ((prime? n)
            (display n)
            (newline)
            (continue-primes (next-odd n) (- count 1)))
          (else
            (continue-primes (next-odd n) count))))
