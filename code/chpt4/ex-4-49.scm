;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-10
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.49
;;
;; Alyssa P. Hacker is more interested in generating interesting
;; sentences than in parsing them. She reasons that by simply changing
;; the procedure parse-word so that it ignores the ``input sentence''
;; and instead always succeeds and generates an appropriate word, we
;; can use the programs we had built for parsing to do generation
;; instead. Implement Alyssa's idea, and show the first half-dozen or
;; so sentences generated
;;
;; =============================================================================

;; noun words
(ambeval '(define nouns '(noun student professor cat class))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; verb words
(ambeval '(define verbs '(verb studies lectures eats sleeps))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; article words
(ambeval '(define articles '(article the a))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; preposition words
(ambeval '(define prepositions '(prep for to in by with))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; generate a word
(ambeval '(define (generate-word word-list)
            (require (not (null? (cdr word-list))))
            (amb (list (car word-list)
                       (car (cdr word-list)))
                 (generate-word (cons (car word-list)
                                      (cdr (cdr word-list))))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; generate a prepositional phrase
(ambeval '(define (generate-prepositional-phrase)
            (list 'prep-phrase
                  (generate-word prepositions)
                  (generate-noun-phrase)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; generate the noun phrase
(ambeval '(define (generate-simple-noun-phrase)
            (list 'simple-noun-phrase
                  (generate-word articles)
                  (generate-word nouns)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (generate-noun-phrase)
            (define (maybe-extend noun-phrase)
              (amb noun-phrase
                   (maybe-extend (list 'noun-phrase
                                       noun-phrase
                                       (generate-prepositional-phrase)))))
            (maybe-extend (generate-simple-noun-phrase)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; generate a verb phrase
(ambeval '(define (generate-verb-phrase)
            (define (maybe-extend verb-phrase)
              (amb verb-phrase
                   (maybe-extend (list 'verb-phrase
                                       verb-phrase
                                       (generate-prepositional-phrase)))))
            (maybe-extend (generate-word verbs)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; generate a sentence
(ambeval '(define (generate-sentence)
            (list 'sentence
                  (generate-noun-phrase)
                  (generate-verb-phrase)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
