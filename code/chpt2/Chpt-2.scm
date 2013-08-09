;;; chapter 2
;;  p56
;;
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (numer y) (denom x))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

;;  p57
;;
(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;;  p58
;   simplification version
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

;; exercise 2.1
;;
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cond ((> d 0)
           (cons (/ n g) (/ d g)))
          ((< d 0)
           (cons (- (/ n g)) (- (/ d g))))
          (else (error "0 can not be a denominator")))))

;; exercise 2.2
;;
(define (midpoint-segment s)
  (make-point (/ (+ (x-point (start-segment s))
                    (x-point (end-segment s)))
                 2)
              (/ (+ (y-point (start-segment s))
                    (y-point (end-segment s)))
                 2)))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;; exercise 2.3
;;
(define (rec-perimeter r)
  (* 2 (+ (rec-length r) (rec-width r))))

(define (rec-area r)
  (* (rec-length r) (rec-width r)))

;--------------Interface-----------------
; one possible implementation for a rectangle
(define (make-rec p s1 s2 angle)
  (cons p (cons s1 (cons s2 angle))))

(define (rec-length r)
  (car (cdr r)))

(define (rec-width r)
  (car (cdr (cdr r))))

; another possible implementation for a rectangle
(define (make-rec p1 p2 angle)
  (cons p1 (cons p2 angle)))

(define (segment-length s)
  (let ((l (- (x-point (start-segment s))
              (x-point (end-segment s))))
        (w (- (y-point (start-segment s))
              (y-point (end-segment s)))))
    (sqrt (+ (* l l) (* w w)))))

(define (rec-length r)
  (* (sin (cdr (cdr r)))
     (segment-length (make-segment (car r)
                                    (car (cdr r))))))
(define (rec-width r)
  (* (cos (cdr (cdr r)))
     (segment-length (make-segment (car r)
                                    (car (cdr r))))))

;; p61
;;
(define (p61-cons x y)
  (lambda (m)
    (cond ((= m 0) x)
          ((= m 1) y))))

(define (p61-car z) (z 0))
(define (p61-cdr z) (z 1))

;; exercise 2.4
;;
(define (ex-2-4-cons x y)
  (lambda (m) (m x y)))

(define (ex-2-4-car z)
  (z (lambda (p q) p)))

(define (ex-2-4-cdr z)
  (z (lambda (p q) q)))

;; exercise 2.5
;;
(define (ex-2-5-cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (ex-2-5-car z)
  (define (iter n a)
    (if (= (remainder a 2) 0)
      (iter (+ n 1) (/ a 2))
      n))
  (iter 0 z))

(define (ex-2-5-cdr z)
  (define (iter n a)
    (if (= (remainder a 3) 0)
      (iter (+ n 1) (/ a 3))
      n))
  (iter 0 z))

;; exercise 2.6
;;
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define (add m n)
  (lambda (f)
    (lambda (x) ((m f) ((n f) x)))))

; test
; ((zero (lambda (x) (+ x 1))) 0)
; ((one (lambda (x) (+ x 1))) 0)
; ((two (lambda (x) (+ x 1))) 0))
; (((add one two) (lambda (x) (+ x 1))) 0)

;; p63
;; Interval arithmetic
;;
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;; exercise 2.7
;;
(define (make-interval a b) (cons a b))

(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

;; exercise 2.8
;;
(define (sub-interval x y)
  (add-interval x
                (make-interval (- (upper-bound y))
                               (- (lower-bound y)))))

;; exercise 2.9
;;
(define (div-interval x y)
  (let ((l (lower-bound y))
        (u (upper-bound y)))
    (if (or (= (* l u) 0)
            (< (* l u) 0))
      (error "divide by 0 error")
      (mul-interval x
                    (make-interval (/ 1.0 u)
                                   (/ 1.0 l))))))

;; test 
;; (define r1 (make-center-percent 1 0.01))
;; (define r2 (make-center-percent 2 0.02))
;; (par1 r1 r2)
;; (par2 r1 r2)



;; p64
;;
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2.0))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2.0))

;; exercise 2.12
;;
(define (make-center-percent c p)
  (make-interval (* c (- 1 p))
                 (* c (+ 1 p))))

(define (percent i)
  (let ((c (center i)))
    (if (= c 0)
      (error "divide by 0 error in calculating percent")
      (/ (/ (- (upper-bound i) (lower-bound i)) c) 2.0))))

;; exercise 2.13
;;
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; exercise 2.17
(define (last-pair items)
  (if (null? items)
    (error "empty list")
    (if (null? (cdr items))
      items
      (last-pair (cdr items)))))

;; exercise 2.18
(define (reverse-recu items)
  (if (null? items)
    items
    (append (reverse-recu (cdr items))
            (list (car items)))))

(define (reverse items)
  (define (iter e l)
    (if (null? l)
      e
      (iter (cons (car l) e) (cdr l))))
  (iter '() items))

;; exercise 2.19
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
          (+ (cc amount
                 (except-first-denomination coin-values))
             (cc (- amount
                     (first-denomination coin-values))
                  coin-values)))))

(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))

;; exercise 2.20
(define (same-parity item . l)
  (define (iter items res)
    (if (null? items)
      res
      (if (even? (- item (car items)))
        (iter (cdr items) (cons (car items) res))
        (iter (cdr items) res))))
  (cons item (iter (reverse l) '())))

;; p70
;;
(define (scale-list items factor)
  (if (null? items)
    items
    (cons (* factor (car items))
          (scale-list (cdr items) factor))))


  
;; exercise 2.21
(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
    items
    (cons (square (car items))
          (square-list (cdr items)))))

(define (square-list-map items)
  (map square items))

;; exercise 2.22
(define (for-each proc items)
  (if (null? items)
    (begin (newline)
           (display "Finished"))
    (begin (proc (car items))
           (for-each proc (cdr items)))))

; test
; (for-each (lambda (x) (newline) (display x)) (list 1 2 3 4))

;; p73
;;
(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else
          (+ (count-leaves (car tree))
             (count-leaves (cdr tree))))))

;; exercise 2.25
(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
(car (car '((7))))
(cadr (cadr (cadr (cadr (cadr (cadr '(1 (2 (3 (4 (5 (6 7))))))))))))

;; exercise 2.26
(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y)
(cons x y)
(list x y)

;; exercise 2.27
(define (deep-reverse tree)
  (define (iter items res)
    (cond ((null? items)
           res)
          ((not (pair? items))
           (error "Not a list"))
          ((not (pair? (car items)))
           (iter (cdr items) (cons (car items) res)))
          (else
            (iter (cdr items) (cons (iter (car items) '()) res)))))
  (iter tree '()))

(define (deep-reverse-recu tree)
  (cond ((null? tree)
         tree)
        ((not (pair? tree)) tree)
        (else
          (append (deep-reverse-recu (cdr tree))
                  (list (deep-reverse-recu (car tree)))))))

; test
(define x '(() 0 (1 2 () 3) ((4 5) 6 (7 8))))
(deep-reverse x)
(deep-reverse-recu x)

;; exercise 2.28
(define (fringe tree)
  (define (fringe-car tree)
    (if (not (pair? tree))
      (list tree)
      (fringe tree)))
  (if (null? tree)
    tree
    (append (fringe-car (car tree))
            (fringe (cdr tree)))))

; test
; (fringe x)

;; ex 2.29
(define (make-mobile left right)
  (list left right))

(define (make-branch len struct)
  (list len struct))

; a)
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-struct branch)
  (cadr branch))

; b)
(define (total-weight mobile)
  (cond ((null? mobile) 0)
        (else
          (let ((ls (branch-struct (left-branch mobile)))
                (rs (branch-struct (right-branch mobile))))
            (+ (if (not (pair? ls))
                 ls
                 (total-weight ls))
               (if (not (pair? rs))
                  rs
                  (total-weight rs)))))))

; test
(define a-mobile (make-mobile 
                   (make-branch 1 30)
                   (make-branch 
                      3 
                      (make-mobile
                         (make-branch 4 6)
                         (make-branch 6 4)))))

(total-weight a-mobile)

; c)
(define (branch-length branch)
  (car branch))

(define (mobile-balance? mobile)
  (if (null? mobile)
    #t
    (let ((lm (left-branch mobile))
          (rm (right-branch mobile)))
      (let ((ls (branch-struct lm))
            (rs (branch-struct rm)))
        (and 
          (if (not (pair? ls)) #t (mobile-balance? ls))
          (if (not (pair? rs)) #t (mobile-balance? rs))
          (= (* (branch-length lm)
                (if (not (pair? ls)) ls (total-weight ls)))
             (* (branch-length rm)
                 (if (not (pair? rs)) rs (total-weight rs)))))))))

; test
(mobile-balance? a-mobile)

; d)
(define (make-mobile left right)
  (cons left right))

; 修改的部份
(define (right-branch mobile)
  (cdr mobile))

(define (make-branch len struct)
  (cons len struct))

; 修改的部份
(define (branch-struct branch)
  (cdr branch))

(define a-mobile (make-mobile
                   (make-branch 1 30)
                   (make-branch
                      3
                      (make-mobile
                         (make-branch 4 6)
                         (make-branch 6 4)))))

;; exercise 2.30
(define (square-tree tree)
  (map (lambda (x)
         (if (pair? x)
            (square-tree x)
            (* x x)))
       tree))

; test
(define a-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

(square-tree a-tree)

(define (square-tree-direct tree)
  (cond ((null? tree) tree)
        ((not (pair? tree)) (* tree tree))
        (else
          (cons
            (square-tree-direct (car tree))
            (square-tree-direct (cdr tree))))))

; test
(square-tree-direct a-tree)

;; exercise 2.31
(define (tree-map proc tree)
  (cond ((null? tree) tree)
        ((not (pair? tree)) (proc tree))
        (else
          (cons
            (tree-map proc (car tree))
            (tree-map proc (cdr tree))))))

; test
(define (square-tree-map tree)
  (tree-map (lambda (x) (* x x)) tree))

(square-tree-map a-tree)
;; exercise 2.32
(define (subsets s)
  (if (null? s)
    (list s)
    (let ((sub (subsets (cdr s)))
          (first (car s)))
      (append
        (map (lambda (x) (cons first x)) sub)
        sub))))

;; p78
(define (filter predicate seq)
  (cond ((null? seq) '())
        ((predicate (car seq))
         (cons (car seq)
                (filter predicate (cdr seq))))
        (else (filter predicate (cdr seq)))))

(define (accumulate op initial seq)
  (if (null? seq)
    initial
    (op (car seq)
        (accumulate op initial (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ 1 low) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else
          (append (enumerate-tree (car tree))
                  (enumerate-tree (cdr tree))))))

;; p79
(define (sum-odd-squares tree)
  (accumulate + 0 (map square
                       (filter odd?
                                (enumerate-tree tree)))))

(define (fib n)
  (define (iter a b m)
    (if (= m 0)
      b
      (iter (+ a b) a (- m 1))))
  (iter 1 0 n))

(define (even-fibs n)
  (accumulate cons '()
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

;; exercise 2.33
; (define (map p seq)
;   (accumulate (lambda (x y) (cons (p x) y)) '() seq))

; (define (append seq1 seq2)
;   (accumulate cons seq2 seq1))

; (define (length seq)
;   (accumulate (lambda (x y) (+ 1 y)) 0 seq))

;; exercise 2.34
(define (horner-eval x coeff-seq)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coeff-seq))

; test
(horner-eval 2 (list 1 3 0 5 0 1))

;; exercise 2.35
(define (count-leaves tree)
  (accumulate + 0 (map (lambda (x)
                         (if (pair? x) (count-leaves x) 1))
                       tree)))

;; exercise 2.36
(define (accumulate-n op init seqs-in-seq)
  (if (null? (car seqs-in-seq))
    '()
    (cons (accumulate op init (map car seqs-in-seq))
          (accumulate-n op init (map cdr seqs-in-seq)))))

;; exercise 2.37
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(define (transpose m)
  (accumulate-n cons '() m))

(define (matrix-*-matrix m1 m2)
  (map (lambda (x) (matrix-*-vector (transpose m2) x)) m1))

;; exercise 2.38
(define (fold-left op init seq)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter init seq))

(define (fold-right op init seq) (accumulate op init seq))

; test
(fold-right / 1 '(1 2 3))
(fold-left / 1 '(1 2 3))
(fold-right list '() '(1 2 3))
(fold-left list '() '(1 2 3))

(define (ooops x y)
  (fringe (list x y)))

(fold-right ooops '() '(1 2 3 4 5))
(fold-left ooops '() '(1 2 3 4 5))

;; exercise 2.39
(define (reverse-right seq)
  (fold-right (lambda (x y) (append y (list x))) '() seq))

(define (reverse-left seq)
  (fold-left (lambda (x y) (cons y x)) '() seq))

;; p83
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

;; p84
(define (permutation s)
  (if (null? s)
    (list '())
    (flatmap (lambda (x)
               (map (lambda (p) (cons x p))
                     (permutation (remove x s))))
             s)))

(define (remove item seq)
  (filter (lambda (x) (not (= item x))) seq))

;; exercise 2.40
(define (unique-pairs n)
  (flatmap (lambda (x)
             (map (lambda (y)
                     (list x y))
                   (enumerate-interval 1 (- x 1))))
           (enumerate-interval 1 n)))

;; exercise 2.41
(define (unique-triples n)
  (flatmap
    (lambda (x)
      (flatmap
        (lambda (y)
          (map
            (lambda (z)
              (cons x (list y z)))
            (enumerate-interval 1 (- y 1))))
        (enumerate-interval 1 (- x 1))))
    (enumerate-interval 1 n)))

(define (constant-sum-triple const n)
  (filter (lambda (x)
            (= const
               (accumulate + 0 x)))
          (unique-triples n)))

;; exercise 2.42
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (position) (safe? position))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (queens-slow board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (position) (safe? position))
        (flatmap
          (lambda (new-row)
            (map (lambda (rest-of-queens)
                   (adjoin-position new-row rest-of-queens))
                 (queen-cols (- k 1))))
          (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

(define (time proc parameter)
  (newline)
  (let ((start (runtime)))
    (proc parameter)
    (let ((end (runtime)))
      (- end start))))

(define empty-board '())

(define (adjoin-position new-row rest-of-queens)
  (cons new-row rest-of-queens))

(define (safe? position)
  (define (same-row? current)
    (accumulate (lambda (x y) (or x y))
                #f
                (map (lambda (x) (= current x))
                     (cdr position))))
  (define (diagonal? current)
    (define (iter result rest diff)
      (cond (result #t)
            ((null? rest) result)
            (else
              (iter (or (= (- current diff) (car rest))
                        (= (+ current diff) (car rest)))
                    (cdr rest)
                    (+ 1 diff)))))
    (iter #f (cdr position) 1))
  (not (or (same-row? (car position))
           (diagonal? (car position)))))

;; exercise 2.43
;; =. (n/c)^n T; c is a coefficient which varies depend on n

;; exercise 2.44 -- exercose 2.52
;;

;; p98
(define (memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

;; exercise 2.53
;;
; (list 'a 'b 'c)
; (list (list 'george))
; (cdr '((x1 x2) (y1 y2)))
; (cadr '((x1 x2) (y1 y2)))
; (pair? (car '(a short list)))
; (memq 'red '((red shoes) (blue socks)))

;; exercise 2.54
(define (ex-equal? l1 l2)
  (cond ((and (pair? l1) (pair? l2))
         (and (ex-equal? (car l1) (car l2))
               (ex-equal? (cdr l1) (cdr l2))))
        ((and (not (pair? l1)) (not (pair? l2)))
         (eq? l1 l2))
        (else #f)))

;; p100
;;
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((d-variable? exp)
         (if (d-same-variable? exp var) 1 0))
        ((d-sum? exp)
         (d-make-sum (deriv (d-addend exp) var)
                      (deriv (d-augend exp) var)))
        ((d-product? exp)
         (d-make-sum
            (d-make-product (d-multiplier exp)
                             (deriv (d-multiplicand exp) var))
            (d-make-product (deriv (d-multiplier exp) var)
                             (d-multiplicand exp))))
        (else
          (error "Unknown expression type -- DERIV" exp))))

(define (d-variable? x) (symbol? x))
(define (d-same-variable? x y)
  (and (d-variable? x) (d-variable? y) (eq? x y)))
(define (d-make-sum a1 a2) (list '+ a1 a2))
(define (d-sum? e)
  (and (pair? e) (eq? '+ (car e))))
(define (d-addend s) (cadr s))
(define (d-augend s) (caddr s))
(define (d-make-product a1 a2) (list '* a1 a2))
(define (d-product? e)
  (and (pair? e) (eq? '* (car e))))
(define (d-multiplier p) (cadr p))
(define (d-multiplicand p) (caddr p))

(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (d-make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (d-make-product a1 a2)
  (cond ((=number? a1 1) a2)
        ((=number? a2 1) a1)
        ((or (=number? a1 0) (=number? a2 0)) 0)
        ((and (number? a1) (number? a2)) (* a1 a2))
        (else (list '* a1 a2))))

;; exercise 2.56
(define (d-make-exponentiation base exponent)
  (cond ((number? base) (expt base exponent))
        ((= exponent 1) base)
        ((= exponent 0) 1)
        (else (list '^ base exponent))))
(define (d-base e) (cadr e))
(define (d-exponent e) (caddr e))
(define (d-exponentiation? e)
  (and (pair? e) (eq? '^ (car e))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((d-variable? exp)
         (if (d-same-variable? exp var) 1 0))
        ((d-sum? exp)
         (d-make-sum (deriv (d-addend exp) var)
                      (deriv (d-augend exp) var)))
        ((d-product? exp)
         (d-make-sum
            (d-make-product (d-multiplier exp)
                             (deriv (d-multiplicand exp) var))
            (d-make-product (deriv (d-multiplier exp) var)
                             (d-multiplicand exp))))
        ((d-exponentiation? exp)
         (d-make-product
            (d-make-product (d-exponent exp)
                             (d-make-exponentiation (d-base exp)
                                                     (- (d-exponent exp) 1)))
            (deriv (d-base exp) var)))
        (else
          (error "Unknown expression type -- DERIV" exp))))

;; exercise 2.57
(define (d-augend e)
  (let ((rest (cddr e)))
    (if (null? (cdr rest))
      (car rest)
      (cons '+ rest))))

(define (d-multiplicand e)
  (let ((rest (cddr e)))
    (if (null? (cdr rest))
      (car rest)
      (cons '* rest))))

;; exercise 2.58
;; a)
(define (d-make-sum a1 a2) (list a1 '+ a2))
(define (d-sum? e)
  (and (pair? e) (eq? '+ (cadr e))))
(define (d-addend s) (car s))
(define (d-augend s) (caddr s))
(define (d-make-product a1 a2) (list a1 '* a2))
(define (d-product? e)
  (and (pair? e) (eq? '* (cadr e))))
(define (d-multiplier e) (car e))
(define (d-multiplicand e) (caddr e))

(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (d-make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))
(define (d-make-product a1 a2)
  (cond ((=number? a1 1) a2)
        ((=number? a2 1) a1)
        ((or (=number? a1 0) (=number? a2 0)) 0)
        ((and (number? a1) (number? a2)) (* a1 a2))
        (else (list a1 '* a2))))

;; b)
(define (d-sum? exp)
  (accumulate (lambda (x y) (or x y))
              #f
              (map (lambda (x) (eq? '+ x)) exp)))

(define (d-addend e)
  (define (addend e)
    (if (eq? (car e) '+)
      '()
      (cons (car e) (addend (cdr e)))))
  (if (eq? (cadr e) '+)
    (car e)
    (addend e)))

(define (d-augend e)
  (if (eq? '+ (car e))
    (if (null? (cddr e))
      (cadr e)
      (cdr e))
    (d-augend (cdr e))))

(define (d-multiplicand e)
  (let ((rest (cddr e)))
    (if (null? (cdr rest))
      (car rest)
      rest)))

;; p103
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))

(define (intersection set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
                (intersection (cdr set1) set2)))
        (else (intersection (cdr set1) set2))))

;; exercise 2.59
(define (union set1 set2)
  (cond ((null? set1) set2)
        ((element-of-set? (car set1) set2)
         (union (cdr set1) set2))
        (else (cons (car set1) (union (cdr set1) set2))))) 

;; exercise 2.60
;; ignore some 'exist in set' check

;; exercise 2.61
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (cdr set)))))

(define (intersection set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((= x1 x2) (cons x1
                             (intersection (cdr set1) (cdr set2))))
            ((< x1 x2)
             (intersection (cdr set1) set2))
            ((> x1 x2)
             (intersection set1 (cdr set2)))))))

;; exercise 2.61
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

;; exercise 2.62
(define (union set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
          (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2) (cons x1 (union (cdr set1) (cdr set2))))
                  ((< x1 x2) (cons x1 (union (cdr set1) set2)))
                  ((> x1 x2) (cons x2 (union set1 (cdr set2)))))))))

;; p107
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set)) (element-of-set? (left-branch set)))
        ((> x (entry set)) (element-of-set? (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                     (adjoin-set x (left-branch set))
                     (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                     (left-branch set)
                     (adjoin-set x (right-branch set))))))

;; tree 1 on p106
(define tree1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define tree2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define tree3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))

;; p108
(define (tree->list-1 tree)
  (if (null? tree)
    '()
    (append (tree->list-1 (left-branch tree))
            (cons (entry tree)
                  (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result)
    (if (null? tree)
      result
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
                          (copy-to-list (right-branch tree)
                                        result)))))
  (copy-to-list tree '()))

;; exercise 2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-tree (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-tree))
                (right-result (partial-tree (cdr non-left-tree)
                                            right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts (cdr right-result)))
              (cons (make-tree this-entry left-tree right-tree)
                    remaining-elts))))))))

;; exercise 2.65
(define (union-set set1 set2)
  (let ((s1 (tree->list-2 set1))
        (s2 (tree->list-2 set2)))
    (list->tree (union s1 s2))))

(define (intersection-set set1 set2)
  (let ((s1 (tree->list-2 set1))
        (s2 (tree->list-2 set2)))
    (list->tree (intersection s1 s2))))

;; exercise 2.66
;; skip, too simple, look p106-p107 example 'element-of-set?'

;; p112
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? obj)
  (eq? (car obj) 'leaf))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-huffman-code left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-side huffman-tree) (car huffman-tree))

(define (right-side huffman-tree) (cadr huffman-tree))

(define (symbols huffman-tree)
  (if (leaf? huffman-tree)
    (list (symbol-leaf huffman-tree))
    (caddr huffman-tree)))

(define (weight huffman-tree)
  (if (leaf? huffman-tree)
    (weight-leaf huffman-tree)
    (cadddr huffman-tree)))

;; p113
(define (decode bits huffman-tree)
  (define (decode-1 bits current-side)
    (if (null? bits)
      '()
      (let ((next-side
              (choose-side (car bits) current-side)))
        (if (leaf? next-side)
          (cons (symbol-leaf next-side)
                (decode-1 (cdr bits) huffman-tree))
          (decode-1 (cdr bits) next-side)))))
  (decode-1 bits huffman-tree))

(define (choose-side bit side)
  (cond ((= bit 0) (left-side side))
        ((= bit 1) (right-side side))
        (else (error "bad bit -- CHOOSE-SIDE" bit))))

(define (adjoin-huffman x set)
  (cond ((null? set) (list x))
        ((> (weight x) (weight (car set)))
         (cons (car set) (adjoin-huffman x (cdr set))))
        (else (cons x set))))

;; p114
(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-huffman (make-leaf (car pair)
                                 (cadr pair))
                      (make-leaf-set (cdr pairs))))))

;; exercise 2.67
(define sample-huffman-tree
  (make-huffman-code (make-leaf 'A 4)
                     (make-huffman-code
                        (make-leaf 'B 2)
                        (make-huffman-code (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;; exercise 2.68
(define (encode message huffman-tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) huffman-tree)
            (encode (cdr message) huffman-tree))))

(define (encode-symbol symbol huffman-tree)
  (define (exist? s set)
    (cond ((null? set) #f)
          ((equal? s (car set)) #t)
          (else (exist? s (cdr set)))))
  (define (encode-1 current-side)
    (if (leaf? current-side)
      (if (equal? symbol (symbol-leaf current-side))
        '()
        (error "Unknown symbol -- ENCODE-SYMBOL" symbol))
      (let ((left (left-side current-side))
            (right (right-side current-side)))
        (if (exist? symbol (symbols left))
          (cons 0 (encode-1 left))
          (cons 1 (encode-1 right))))))
    (encode-1 huffman-tree))

;; exercise 2.69
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (null? (cdr leaf-set))
    (car leaf-set)
    (let ((e1 (car leaf-set))
          (e2 (cadr leaf-set))
          (rest (cddr leaf-set)))
      (successive-merge
        (adjoin-huffman (make-huffman-code e1 e2) rest)))))

;; exercise 2.70
(define pairs '((A 2) (NA 16) (BOOM 1) (SHA 3)
                (GET 2) (YIP 9) (JOB 2) (WAH 1)))

(define message-song '(Get a job Sha na na na na na na na na
                       Get a job Sha na na na na na na na na
                       Wah yip yip yip yip yip yip yip yip yip
                       Sha boom))
(encode message-song (generate-huffman-tree pairs))

;; 84 bits with huffman code
;; 108 bits with 3-bits code

;; exercise 2.71
;; n-1 for least frequent symbol
;; 1 for most frequent symbol

;; exercise 2.72
;; O(1) for most frequent symbol
;; O(n) for least frequent symbol

;; p123-p124
(define global-array '())

(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))

(define (put op type item)
  (define (put-helper k array)
    (cond ((null? array) (list (make-entry k item)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! global-array (put-helper (list op type) global-array)))

(define (get op type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list op type) global-array))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
    (car datum)
    (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
    (cdr datum)
    (error "Bad tagged datum -- CONTENTS" datum)))

(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
(install-rectangular-package)

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
(install-polar-package)

;; p125
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error 
          "No method for these types -- APPLY-GENERIC"
          (list op type-tags))))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

;; exercise 2.73
;; exercise 2.74
;; exercise 2.75
;; exercise 2.76

;; p129
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)
(install-scheme-number-package)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

  ;; interface to the rest system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)
(install-rational-package)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

  ;; internal procedures
  (define (add z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

  ;; interface to the rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div z1 z2))))
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
(install-complex-package)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

;; exercise 2.77
;; apply-generic 'magnitude '(complex)
;;   => magnitude = apply-generic 'magnitude '(rectangular/polar)
;;     => magnitude = real magnitude for polar or rectangular

; test
(define n1 (make-scheme-number 1))
(define n2 (make-scheme-number 2))
(define r1 (make-rational 2 5))
(define r2 (make-rational 4 8))
(define z1 (make-complex-from-real-imag 1 2))
(define z2 (make-complex-from-mag-ang 3 4))

;;(define (apply-generic op . args)
;;  (let ((type-tags (map type-tag args)))
;;    (let ((proc (get op type-tags)))
;;      (if proc
;;        (apply proc (map contents args))
;;        (if (= (length args) 2)
;;          (let ((type1 (car type-tags))
;;                (type2 (cadr type-tags))
;;                (a1 (car args))
;;                (a2 (cadr args)))
;;            (let ((t1->t2 (get-coercion type1 type2))
;;                  (t2->t1 (get-coercion type2 type1)))
;;              (cond (t1->t2
;;                      (apply-generic op (t1->t2 a1) a2))
;;                    (t2->t1
;;                      (apply-generic op a1 (t2->t1 a2)))
;;                    (else
;;                      (error "No method for these types"
;;                             (list op type-tags))))))
;;          (error "No method for these types"
;;                 (list op type-tags)))))))

;; exercise 2.81
;; exercise 2.82
;; exercise 2.83
;; exercise 2.84
;; exercise 2.85
;; exercise 2.86

;; p138

;; exercise 2.87
;; exercise 2.88
;; exercise 2.89
;; exercise 2.90
;; exercise 2.91
;; exercise 2.92
;; exercise 2.93
;; exercise 2.94
;; exercise 2.95
;; exercise 2.96
;; exercise 2.97
