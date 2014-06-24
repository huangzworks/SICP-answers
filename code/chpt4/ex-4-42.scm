;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.42
;;
;; Solve the following ``Liars'' puzzle (from Phillips 1934):
;;
;; Five schoolgirls sat for an examination. Their parents -- so they
;; thought -- showed an undue degree of interest in the result. They
;; therefore agreed that, in writing home about the examination, each
;; girl should make one true statement and one untrue one. The
;; following are the relevant passages from their letters:
;; - Betty: ``Kitty was second in the examination. I was only third.''
;; - Ethel: ``You'll be glad to hear that I was on top. Joan was second.''
;; - Joan: ``I was third, and poor old Ethel was bottom.''
;; - Kitty: ``I came out second. Mary was only fourth.''
;; - Mary: ``I was fourth. Top place was taken by Betty.''
;; What in fact was the order in which the five girls were placed?
;;
;; =============================================================================


(ambeval '(define (BEJKM-order)
            (let ((Betty (amb 1 2 3 4 5))
                  (Ethel (amb 1 2 3 4 5))
                  (Joan (amb 1 2 3 4 5))
                  (kitty (amb 1 2 3 4 5))
                  (Mary (amb 1 2 3 4 5)))
              (require (distinct? (list Betty Ethel Joan Kitty Mary)))
              (require (or (and (= Kitty 2) (not (= Betty 3)))
                           (and (not (= Kitty 2)) (= Betty 3))))
              (require (or (and (= Ethel 1) (not (= Joan 2)))
                           (and (not (= Ethel 1)) (= Joan 2))))
              (require (or (and (= Joan 3) (not (= Ethel 5)))
                           (and (not (= Joan 3)) (= Ethel 5))))
              (require (or (and (= Kitty 2) (not (= Mary 4)))
                           (and (not (= Kitty 2)) (= Mary 4))))
              (require (or (and (= Mary 4) (not (= Betty 1)))
                           (and (not (= Mary 4)) (= Betty 1))))
              (list (list 'Betty Betty)
                    (list 'Ethel Ethel)
                    (list 'Joan Joan)
                    (list 'Kitty Kitty)
                    (list 'Mary Mary))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

