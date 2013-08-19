;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-08-18
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.11
;;
;; Instead of representing a frame as a pair of lists, we can
;; represent a frame as a list of bindings, where each binding is a
;; name-value pair. Rewrite the environment operations to use this
;; alternative representation.
;;
;; =============================================================================


;; Frame
;; modificaition: a pair of list => list of pairs
;; Each frame of an environment is represented as a list of pairs of binding
;; name-value pair

;; use this structure, there are a lot of difficulties
;; for make-frame, we should distinguish if variables and values are null, and
;; then we must treat them differently as for add-binding-to-frame! use
(define (make-frame variables values)
  (define (make-frame-for-non-null vars vals)
    (if (null? vars)
        '()
        (cons (cons (car vars) (car vals))
              (make-frame-for-non-null (cdr vars) (cdr vals)))))
  (if (null? variables)
      (cons '() '())
      (make-frame-for-non-null variables values)))

;; remember the frame could be '(())
(define (frame-variables frame)
  (if (null? (car frame))
      '()
      (map car frame)))

;; In fact the frame-values procedure is useless, the only purpose of
;; defining it is in case you want to call it explicitly, but remember,
;; even you set! the value in frame-values, it will NOT affect the frame,
;; only add-binding-to-frame!, define-variable!, set-variable-value
;; can modify a frame or a frame in an environment.
(define (frame-values frame)
  (if (null? (car frame))
      '()
      (map cdr frame)))

;; this procedure requires that the frame must be a pair, it checks
;; that if the first element of the frame is null, if yes, it set the
;; first element to the new binding, if no, it insert the new binding
;; between the first and second element, after then the new binding
;; always inserts at this place.
;; That is why when construct a frame with make-frame, even variables
;; and values are null we can not simply give '()
(define (add-binding-to-frame! var val frame)
  (if (null? (car frame))
      (set-car! frame (cons var val))
      (set-cdr! frame (cons (cons var val)
                            (cdr frame)))))

;; We must re-define the two procedure but keeping its form since we don't
;; want to change those procedure who calls them
;; why we must change them is that :
;; (see footnote 14 at textbook in chapter 4
;; http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-26.html#footnote_Temp_544
;; or footnote 218 for the chinese translation version SICP )
;; Frames are not really a data abstraction in the following code:
;; Set-variable-value! and define-variable! use set-car! to directly
;; modify the values in a frame.
;; This is just a great example to show the importance of data abstraction,
;; if we use data abstraction at first place, which means we should have
;; something like (frame-set-variable-value! var val frame), then the two
;; procedure define-variable! and set-variable-value! only need to call them,
;; and now what we need to do is to modify the procedure
;; frame-set-variable-value! and leave all others alone.

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars f)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-cdr! (car f) val))
            (else (scan (cdr vars) (cdr frame)))))
    (scan (frame-variables frame)
          frame)))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars frame)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-cdr! (car frame) val))
            (else (scan (cdr vars) (cdr frame)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame) frame))))
  (env-loop env))
