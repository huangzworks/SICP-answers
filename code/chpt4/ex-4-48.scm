;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-07
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.48
;;
;; Extend the grammar given above to handle more complex
;; sentences. For example, you could extend noun phrases and verb
;; phrases to include adjectives and adverbs, or you could handle
;; compound sentences
;;
;; =============================================================================


;; Here we will extend the verb phrase to include adverbs

;; First we need adverbs
(ambeval '(define adverbs '(adverb kindly badly))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; Then we need to modify the parse-verb-phrase
;; the adverb may be preceed a verb phrase or succeed a verb phrase
;; however we must make sure the procedure will finish
;; as here we do NOT change the structure of parse-verb-phrase
;; once enter the maybe-extend, it must end at some stage, as there is
;; no more prepositional phrase or adverb succeeding.
;; The different thing is that the argument of maybe-extend, we must
;; prove even with this modification, it always ends.
;; We only need to consider the case that maybe-extend use
;; the second possibility for the argument. However, it will end
;; when there is no more adverbs. So we may conclude that this modified
;; parse-verb-phrase always end at some stage. The key point is that
;; it may even not enter the maybe-extend procedure or once enter, it
;; always ends.
(ambeval '(define (parse-verb-phrase)
            (define (maybe-extend verb-phrase)
              (amb verb-phrase
                   (maybe-extend (list 'verb-phrase
                                       verb-phrase
                                       (parse-prepositional-phrase)))
                   (maybe-extend (list 'verb-phrase
                                       verb-phrase
                                       (parse-word adverbs)))))
            (maybe-extend (amb (parse-word verbs)
                               (list 'verb-phrase
                                     (parse-word adverbs)
                                     (parse-verb-phrase)))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
