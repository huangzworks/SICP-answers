;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-03
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.43
;;
;; Use the amb evaluator to solve the following puzzle:
;; Mary Ann Moore's father has a yacht and so has each of his four
;; friends: Colonel Downing, Mr. Hall, Sir Barnacle Hood, and
;; Dr. Parker. Each of the five also has one daughter and each has
;; named his yacht after a daughter of one of the others. Sir
;; Barnacle's yacht is the Gabrielle, Mr. Moore owns the Lorna,
;; Mr. Hall the Rosalind. The Melissa, owned by Colonel Downing, is
;; named after Sir Barnacle's daughter. Gabrielle's father owns the
;; yacht that is named after Dr. Parker's daughter. Who is Lorna's
;; father?  Try to write the program so that it runs efficiently (see
;; exercise 4.40). Also determine how many solutions there are if we
;; are not told that Mary Ann's last name is Moore.
;;
;; =============================================================================


;; this procedure would give the yacht's name according to the father's name
(ambeval '(define (yacht-belong-to father)
            (cond ((eq? father 'Moore) 'Lorna)
                  ((eq? father 'Downing) 'Melissa)
                  ((eq? father 'Hall) 'Rosalind)
                  ((eq? father 'Hood) 'Gabrielle)
                  ((eq? father 'Parcker) 'Mary)
                  (else (error "No this Father" father))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; define the procedure who-s-father-is-who to find out Lorna's father
(ambeval '(define (who-s-father-is-who)
            (let ((Mary-F (amb 'Moore 'Downing 'Hall)))
              (require (eq? Mary-F 'Moore))
              (let ((Lorna-F (amb 'Downing 'Hall 'Parcker)))
                (require (not (eq? Lorna-F Mary-F)))
                (let ((Rosalind-F (amb 'Moore 'Downing 'Parcker)))
                  (require (and (not (eq? Rosalind-F Mary-F))
                                (not (eq? Rosalind-F Lorna-F))))
                  (let ((Gabrielle-F (amb 'Moore 'Downing 'Hall 'Parcker)))
                    (require (and (not (eq? Gabrielle-F Mary-F))
                                  (not (eq? Gabrielle-F Lorna-F))
                                  (not (eq? Gabrielle-F Rosalind-F))))
                    (define (her-father daughter)
                      (cond ((eq? daughter 'Mary) Mary-F)
                            ((eq? daughter 'Lorna) Lorna-F)
                            ((eq? daughter 'Rosalind) Rosalind-F)
                            ((eq? daughter 'Gabrielle) Gabrielle-F)
                            ((eq? daughter 'Melissa) 'Hood)
                            (else (error "No this daughter" daughter))))
                    (require (eq? (her-father (yacht-belong-to Gabrielle-F))
                                  'Parcker))
                    (list (list 'Mary-s-father Mary-F)
                          (list 'Lorna-s-father Lorna-F)
                          (list 'Rosalind-s-father Rosalind-F)
                          (list 'Gabrielle-s-father Gabrielle-F)
                          (list 'Melissa-s-father 'Hood)))))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; If we don't know Mary Ann's father, just delete the restricton
;; on Mary's father
(ambeval '(define (who-s-father-is-who-multiple)
            (let ((Mary-F (amb 'Moore 'Downing 'Hall)))
              ;; (require (eq? Mary-F 'Moore))                     ; comment this
              (let ((Lorna-F (amb 'Downing 'Hall 'Parcker)))
                (require (not (eq? Lorna-F Mary-F)))
                (let ((Rosalind-F (amb 'Moore 'Downing 'Parcker)))
                  (require (and (not (eq? Rosalind-F Mary-F))
                                (not (eq? Rosalind-F Lorna-F))))
                  (let ((Gabrielle-F (amb 'Moore 'Downing 'Hall 'Parcker)))
                    (require (and (not (eq? Gabrielle-F Mary-F))
                                  (not (eq? Gabrielle-F Lorna-F))
                                  (not (eq? Gabrielle-F Rosalind-F))))
                    (define (her-father daughter)
                      (cond ((eq? daughter 'Mary) Mary-F)
                            ((eq? daughter 'Lorna) Lorna-F)
                            ((eq? daughter 'Rosalind) Rosalind-F)
                            ((eq? daughter 'Gabrielle) Gabrielle-F)
                            ((eq? daughter 'Melissa) 'Hood)
                            (else (error "No this daughter" daughter))))
                    (require (eq? (her-father (yacht-belong-to Gabrielle-F))
                                  'Parcker))
                    (list (list 'Mary-s-father Mary-F)
                          (list 'Lorna-s-father Lorna-F)
                          (list 'Rosalind-s-father Rosalind-F)
                          (list 'Gabrielle-s-father Gabrielle-F)
                          (list 'Melissa-s-father 'Hood)))))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

