;;; To allow parallel execution of any number of thunks, for
;;; effect.  The values are discarded.

(define disallow-preempt-current-thread
  (access disallow-preempt-current-thread
	  (->environment '(runtime thread))))

(define allow-preempt-current-thread
  (access allow-preempt-current-thread
	  (->environment '(runtime thread))))

(define (kill-thread thread)
  (let ((event
	 (lambda ()
	   (exit-current-thread 'RIP))))
    (without-interrupts
     (lambda ()
       (case (thread-execution-state thread)
	 ((STOPPED) (restart-thread thread #t event))
	 ((DEAD) unspecific)
	 (else (signal-thread-event thread event)))))))


(define (parallel-execute . thunks)
  (let ((my-threads '()))
    (define (terminator)
      (without-interrupts
       (lambda ()
	 (for-each kill-thread my-threads)
	 (set! my-threads '())
	 unspecific)))
    (without-interrupts
     (lambda ()
       (set! my-threads
	     (map (lambda (thunk)
		    (let ((thread (create-thread #f thunk)))
		      (detach-thread thread)
		      thread))
		  thunks))
       unspecific))
    terminator))

#|
;;; IO system is not completely interlocked, so...

(define (try n)
  (parallel-execute
   (lambda ()
     (write-line 'hi)
     (let lp ((i 0))
       (if (< i 10000)
	   (lp (1+ i))))
     (write-line 'gjs))
   (lambda ()
     (write-line 'there)
     (let lp ((i 0))
       (if (< i n)
	   (lp (1+ i))))
     (write-line 'foo))))

(define foo (try 9188))
;Value foo

hi
there
foo
foo
gjs

(foo)
;No value
|#

(define (make-serializer)
  (let ((mutex (make-thread-mutex)))
    (define (serialized f)
      (define (serialized-f . args)
	(with-thread-mutex-locked mutex
				  (lambda ()
				    (apply f args))))
      serialized-f)
    serialized))

(define output-serialized (make-serializer))

(define write-line
  (output-serialized write-line))

(define display
  (output-serialized display))

(define write
  (output-serialized write))
#|
;;; This solves the IO interlock problem


(define (try n)
  (parallel-execute
   (lambda ()
     (write-line 'hi)
     (let lp ((i 0))
       (if (< i 10000)
	   (lp (1+ i))))
     (write-line 'gjs))
   (lambda ()
     (write-line 'there)
     (let lp ((i 0))
       (if (< i n)
	   (lp (1+ i))))
     (write-line 'foo))))

(define foo (try 9197))
;Value: foo

hi
there
gjs
foo

(define foo (try 9196))
;Value: foo

hi
there
foo
gjs
|#



