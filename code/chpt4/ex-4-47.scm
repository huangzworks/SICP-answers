;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-06
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.47
;;
;; Louis Reasoner suggests that, since a verb phrase is either a verb
;; or a verb phrase followed by a prepositional phrase, it would be
;; much more straightforward to define the procedure parse-verb-phrase
;; as follows (and similarly for noun phrases):
;;
;; (define (parse-verb-phrase)
;;   (amb (parse-word verbs)
;;        (list 'verb-phrase
;;              (parse-verb-phrase)
;;              (parse-prepositional-phrase))))
;;
;; Does this work? Does the program's behavior change if we
;; interchange the order of expressions in the amb?
;;
;; =============================================================================


;; ANSWER: the answer is NO. HOWEVER, it works except the very last try
;;         (This explanation may be more clear if we just do a test).
;;         In fact, when there is no more prepositional phrase, then the
;;         parse-verb-phrase procedure will get into itself then make
;;         two possible options, and it will again fail in the first option,
;;         and then stuck in the second option in which it again makes two
;;         options in which the first will always fail. So in this version,
;;         it first gives two options and then try to construct a verb phrase,
;;         while in the text's version, maybe-extend will not get into the
;;         body where it gives two options when the argument fails to
;;         construct a verb-phrase. In other words, it always tries to construct
;;         a verb phrase before gives another two options. So it will end
;;         at some stage.
;;
;;         Interchange the order will affect the behavior, but in that case,
;;         things get even worse. Because amb always try the first option which
;;         gives another two options, it simply get stuck in the first option
;;         which is produced by the previous first option, which means it will
;;         never stop


(ambeval '(define (parse-verb-phrase)
            (amb (parse-word verbs)
                 (list 'verb-phrase
                       (parse-verb-phrase)
                       (parse-prepositional-phrase))))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (parse-verb-phrase-2)
            (amb (list 'verb-phrase
                       (parse-verb-phrase)
                       (parse-prepositional-phrase))
                 (parse-word verbs)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
