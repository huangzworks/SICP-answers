;; p150 - p153
;;
(define balance 100)

(define (withdraw amount)
	(if (>= balance amount)
		(begin (set! balance (- balance amount))
					 balance)
		"Insufficient funds"))

(define new-withdraw
	(let ((balance 100))
		(lambda (amount)
			(if (>= balance amount)
				(begin (set! balance (- balance amount))
							 balance)
				"Insufficient funds"))))

(define (make-withdraw balance)
	(lambda (amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount))
						 balance)
			"Insufficient funds")))

(define (make-account balance)
	(define (withdraw amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount))
						 balance)
			"Insufficient funds"))
	(define (deposit amount)
		(set! balance (+ balance amount))
		balance)
	(define (dispatch m)
		(cond ((eq? m 'withdraw) withdraw)
					((eq? m 'deposit) deposit)
					(else (error "Unknow request -- MAKE-ACCOUNT"
											 m))))
	dispatch)

;; exercise 3.1
(define (make-accumulator init)
	(lambda (count)
		(set! init (+ init count))
		init))

;; exercise 3.2
(define (make-monitored f)
	(let ((count 0))
		(define (mf request)
			(cond ((eq? request 'reset)
						 (begin (set! count 0)
						 				count))
						((eq? request 'how-many-calls?) count)
						(else (begin (set! count (+ 1 count))
												 (f request)))))
		mf))

;; exercise 3.3 & 3.4
(define (make-account balance password)
	(define (withdraw amount)
		(if (>= balance amount)
			(begin (set! balance (- balance amount))
						 balance)
			"Insufficient funds"))
	(define (deposit amount)
		(set! balance (+ balance amount))
		balance)
	(let ((count 0))
		(define (message amount)
			(if (>= count 7)
				"Calling police"
				"Incorrect password"))
		(define (dispatch passwd m)
			(if (eq? passwd password)
				(begin (set! count 0)
							 (cond ((eq? m 'withdraw) withdraw)
							 			 ((eq? m 'deposit) deposit)
							 			 ((eq? m 'joint) #t)
							 			 (else (error "Unknown request -- MAKE-ACCOUNT"))))
				(begin (set! count (+ 1 count))
							 message)))
	dispatch))

;; exercise 3.5
(define (monte-carlo trials experiment)
	(define (iter trials-remain trials-passed)
		(cond ((= 0 trials-remain)
					 (/ trials-passed trials))
					((experiment)
					 (iter (- trials-remain 1) (+ trials-passed 1)))
					(else
						(iter (- trials-remain 1) trials-passed))))
	(iter trials 0))

(define (random-in-range low high)
	(let ((range (- high low)))
		(+ low (random range))))

(define (estimate-integral p x1 x2 y1 y2 trials)
	(* (- y2 y1) (- x2 x1) (monte-carlo trials 
																			(lambda ()
																				(p (random-in-range x1 x2)
																					 (random-in-range y1 y2))))))

(define (in-unit-circle? x y)
	(if (<= (+ (* x x) (* y y)) 1) #t #f))

;; exercise 3.6
(define rand
	(let ((x 0))
		(lambda (m)
			(cond ((eq? m 'generate)
						 (set! x (rand-update x)) x)
						((eq? m 'reset)
						 (lambda (value)
						 	 (set! x value) x))
						(else
							(error "Unknown request -- RAND"))))))

(define (rand-update x)
	(remainder (+ (* 5 x) 2) 9))

;; exercise 3.7
(define (make-joint account passwd new-passwd)
	(define (withdraw amount)
		((account passwd 'withdraw) amount))
	(define (deposit amount)
		((account passwd 'deposit) amount))
	(define (dispatch p m)
			(if (eq? p new-passwd)
				(cond ((eq? m 'withdraw) withdraw)
							((eq? m 'deposit) deposit)
							((eq? m 'joint) #t)
							(else (error "Unknown request -- MAKE-ACCOUNT")))))
	(if (account passwd 'joint)
		dispatch
		(error "Incorrect password")))

;; exercise 3.8
(define f
	(let ((x 1))
		(lambda (y)
			(set! x (* x y))
			x)))

