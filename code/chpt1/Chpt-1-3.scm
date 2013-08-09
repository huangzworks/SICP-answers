;; p38-p39

(define (sum term a next b)
	(if (> a b)
		0
		(+ (term a)
			 (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (cube x) (* x x x))
(define (sum-cubes a b)
	(sum cube a inc b))

(define (identity x) x)
(define (sum-integers a b)
	(sum identity a inc b))

(define (pi-sum a b)
	(define (pi-term x)
		(/ 1.0 (* x (+ x 2))))
	(define (pi-next x)
		(+ x 4))
	(sum pi-term a pi-next b))

(define (integral f a b dx)
	(define (add-dx x) (+ x dx))
	(* (sum f (+ a (/ dx 2.0)) add-dx b)
		 dx))

;; exercise 1.29
;;
(define (even? n) (= (remainder n 2) 0))
(define (simpson-integral f a b n)
	(define (end m)
		(if (even? m) m (+ m 1)))
	(define (h a b m) (/ (- b a) (end m)))
	(define (term m)
		(cond ((= m 0) (f a))
					((= m (end n)) (f b))
					((even? m) (* 2 (f (+ a (* m (h a b n))))))
					(else (* 4 (f (+ a (* m (h a b n))))))))
	(/ (* (sum term 0 inc (end n)) (h a b n)) 3))

;; exercise 1.30
;;
(define (sum-iter term a next b)
	(define (iter a res)
		(if (> a b)
			res
			(iter (next a) (+ res (term a)))))
	(iter a 0))

; in order to verify the function (sum-iter term a next b)
(define (pi-sum-iter a b)
	(define (pi-term x)
		(/ 1.0 (* x (+ x 2))))
	(define (pi-next x)
		(+ x 4))
	(sum-iter pi-term a pi-next b))

;; exercise 1.31
;; a)
;;
(define (product term a next b)
	(if (> a b)
		1
		(* (term a) (product term (next a) next b))))

(define (factorial n)
	(product identity 1 inc n))

(define (pi-4 n)
	(define (term m)
		(if (even? m)
			(/ (+ m 2.0) (+ m 1.0))
			(/ (+ m 1.0) (+ m 2.0))))
	(product term 1 inc n))

;; b)
;;
(define (product-iter term a next b)
	(define (iter a res)
		(if (> a b)
			res
			(iter (next a) (* res (term a)))))
	(iter a 1))

(define (factorial-iter n)
	(product-iter identity 1 inc n))

(define (pi-4-iter n)
	(define (term m)
		(if (even? m)
			(/ (+ m 2.0) (+ m 1.0))
			(/ (+ m 1.0) (+ m 2.0))))
	(product-iter term 1 inc n))

;; exercise 1.32
;; a)
(define (accumulate combiner null-value term a next b)
	(if (> a b)
		null-value
		(combiner (term a) (accumulate combiner null-value term (next a) next b))))

;; b)
(define (accumulate-iter combiner null-value term a next b)
	(define (iter a res)
		(if (> a b)
			res
			(iter (next a) (combiner res (term a)))))
	(iter a null-value))

;; in order to verify our "accumulate" procedures
;  sum
(define (sum-acc term a next b)
	(accumulate + 0 term a next b))

(define (sum-acc-iter term a next b)
	(accumulate-iter + 0 term a next b))

(define (sum-integers-acc a b)
	(sum-acc identity a inc b))

(define (sum-integers-acc-iter a b)
	(sum-acc-iter identity a inc b))

;  product
(define (product-acc term a next b)
	(accumulate * 1 term a next b))

(define (product-acc-iter term a next b)
	(accumulate-iter * 1 term a next b))

(define (factorial-acc n)
	(product-acc identity 1 inc n))

(define (factorial-acc-iter n)
	(product-acc-iter identity 1 inc n))

;; exercise 1.32
;;
(define (filtered-accumulate filter combiner null-value term a next b)
	(if (> a b)
		null-value
		(if (filter a)
			(combiner (term a) (filtered-accumulate filter combiner null-value term (next a) next b))
			(filtered-accumulate filter combiner null-value term (next a) next b))))

(define (filtered-accumulate-iter filter combiner null-value term a next b)
	(define (iter a res)
		(if (> a b)
			res
			(if (filter a)
				(iter (next a) (combiner res (term a)))
				(iter (next a) res))))
	(iter a null-value))

;; test
;; a)
(load "p35.scm")
(define (sum-prime-between a b)
	(filtered-accumulate prime? + 0 identity a inc b))

(define (sum-prime-between-iter a b)
	(filtered-accumulate-iter prime? + 0 identity a inc b))

;; b)
(define (product-primes-reless-to n)
  (define (relative-prime? m)
  	(= (gcd m n) 1))
	(filtered-accumulate relative-prime? * 1 identity 1 inc n))

(define (product-primes-reless-to-iter n)
  (define (relative-prime? m)
  	(= (gcd m n) 1))
	(filtered-accumulate-iter relative-prime? * 1 identity 1 inc n))

;; p44 1.3.3
;; find root
(define (search f neg pos)
	(define (average x y)
		(/ (+ x y) 2))
	(let ((mid (average neg pos)))
		(if (close-enough? neg pos)
			mid
			(let ((test-value (f mid)))
				(cond ((positive? test-value)
							 (search f neg mid))
							((negative? test-value)
							 (search f mid pos))
							(else mid))))))

(define (close-enough? x y)
	(< (abs (- x y)) 0.001))

(define (half-interval-method f a b)
	(let ((a-value (f a))
				(b-value (f b)))
		(cond ((= a-value 0) a)
					((= b-value 0) b)
					((and (negative? a-value) (positive? b-value))
					 (search f a b))
					((and (negative? b-value) (positive? a-value))
					 (search f b a))
					(else
						(error "Value are not of opposite sign" a b)))))

;; find fixed point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try next))))
	(try first-guess))

(define (sqrt x)
	(fixed-point (lambda (y) (/ (+ y (/ x y)) 2)) 1.0))

;; exercise 1.35
;; phi
(define (phi)
	(fixed-point (lambda (y) (+ 1 (/ 1 y))) 1.0))

;; exercise 1.36
(define (ex-fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(newline)
			(display next)
			(if (close-enough? next guess)
				next
				(try next))))
	(try first-guess))

(define (x-pow-x-1000)
	(ex-fixed-point (lambda (y) (/ (log 1000) (log y))) 2.0))

(define (x-pow-x-1000-average)
	(ex-fixed-point (lambda (y) (/ (+ y (/ (log 1000) (log y))) 2)) 2.0))

;; exercise 1.37
;  a)
(define (phi-inverse k)
	(cont-frac (lambda (x) 1.0)
						 (lambda (x) 1.0)
						 k))

(define (cont-frac n d k)
	(define (cf total k)
		(if (= k 0)
			0
			(/ (n (- total k)) (+ (d (- total k)) (cf total (- k 1))))))
	(cf (+ k 1) k))

;  b)
(define (cont-frac-iter n d k)
	(define (iter m res)
		(if (= m 0)
			res
			(iter (- m 1) (/ (n m) (+ (d m) res)))))
	(iter k 0))

(define (phi-inverse-iter k)
	(cont-frac-iter (lambda (x) 1.0)
									(lambda (x) 1.0)
									k))

;; exercise 1.37
(define (e k)
	(+ 2 (cont-frac (lambda (k) 1.0)
									(lambda (k) 
										(if (= (remainder k 3) 2)
											(/ (+ 2 (* 2 k)) 3.0)
											1.0))
									k)))


(define (e-iter k)
	(+ 2 (cont-frac-iter (lambda (k) 1.0)
									(lambda (k) 
										(if (= (remainder k 3) 2)
											(/ (+ 2 (* 2 k)) 3.0)
											1.0))
									k)))

;; exercise 1.38
(define (tan-cf x k)
	(cont-frac (lambda (n)
							 (if (> n 1)
							 	 (- (* x x))
							 	 (* x x)))
						 (lambda (n) (- (* 2 n) 1.0))
						 k))

(define (tan-cf-iter x k)
	(cont-frac-iter (lambda (n)
										(if (> n 1)
											(- (* x x))
											(* x x)))
									(lambda (n) (- (* 2 n) 1.0))
									k))

;; p48
;;
(define (average-damp f)
	(lambda (x) (/ (+ x (f x)) 2)))

(define (sqrt-avr-damp x)
	(fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(define (cube-root-avr-damp x)
	(fixed-point (average-damp (lambda (y) (/ x (* y y)))) 1.0))

;; Newton's method
;;
(define dx 0.00001)
(define (deriv g)
	(lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
	(lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
	(fixed-point (newton-transform g) guess))

(define (sqrt-newton x)
	(newtons-method (lambda (y) (- (* y y) x)) 1.0))

;; abstraction and first-class procedures
;;
(define (fixed-point-of-transform g transform guess)
	(fixed-point (transform g) guess))

(define (sqrt-use-average-damp x)
	(fixed-point-of-transform (lambda (y) (/ x y))
														average-damp
														1.0))

(define (sqrt-use-newton-transform x)
	(fixed-point-of-transform (lambda (y) (- (* y y) x))
														newton-transform
														1.0))

;; exercise 1.40
;;
(define (cubic a b c)
	(lambda (x) (+ (* x x x)
								 (* a x x)
								 (* b x)
								 c)))
(define (root-of-cube-polynome a b c)
	(newtons-method (cubic a b c) 1.0))

;; exercise 1.41
(define (double f)
	(lambda (x) (f (f x))))

;; exercise 1.42
(define (compose f g)
	(lambda (x) (f (g x))))

;; exercise 1.43
(define (repeated f n)
	(if (= n 0)
		(lambda (x) x)
		(compose f (repeated f (- n 1)))))

(define (repeated-iter f n)
	(define (iter m res)
		(if (= m 0)
			res
			(iter (- m 1) (compose f res))))
	(iter n (lambda (x) x)))

;; exercise 1.44
(define (smooth f)
	(lambda (x) (/ (+ (f (- x dx))
										(f x)
										(f (+ x dx))) 3.0)))

(define (n-smooth f n)
	((repeated smooth n) f))

(define (n-smooth-iter f n)
	((repeated-iter smooth n) f))

;; exercise 1.45
(define (n-root x pow)
	(fixed-point-of-transform (lambda (y) (/ x (expt y (- pow 1))))
														(repeated average-damp (floor (/ (log pow) (log 2))))
														1.0))

;; exercise 1.46
(define (iterative-improve ok? improve)
	(lambda (guess)
		(if (ok? guess)
			guess
			((iterative-improve ok? improve) (improve guess)))))

;; test
(define (sqrt-ii x)
	(define (improve y)
		(/ (+ y (/ x y)) 2.0))
	((iterative-improve (lambda (y)
												(< (abs (- y (improve y))) tolerance))
											improve)
	 1.0))

(define (fixed-point-ii f first-guess)
	(define (improve guess)
		(f guess))
	((iterative-improve (lambda (y)
												(< (abs (- y (improve y))) tolerance))
											improve)
	 first-guess))
