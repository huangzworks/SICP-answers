;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;                   Chapter 4 Metalinguistic Abstraction
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;==============================================================================
;; 4.3  Variations on a Scheme -- Nondeterministic Computing
;;==============================================================================

;;------------------------------------------------------------------------------
;; 4.3.2  Examples of Nondeterministic Programs
;;------------------------------------------------------------------------------

;; load ambeval analysis and interpretator
(load "chpt-4-3.scm")

;; add primitive operators
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'list list)
        (list 'not not)
        (list 'memq memq)
        (list '= =)
        (list '+ +)
        (list '- -)))

;; define the global environment
(define the-global-environment (setup-environment))

;; define the require procedure
(ambeval '(define (require p) (if p 'ok (amb)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; Parsing natural language
;;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; Programs designed to accept natural language as input usually start by
;; attempting to parse the input, that is, to match the input against
;; some grammatical structure. For example, we might try to recognize
;; simple sentences consisting of an article followed by a noun
;; followed by a verb, such as ``The cat eats.'' To accomplish such an
;; analysis, we must be able to identify the parts of speech of
;; individual words. We could start with some lists that classify
;; various words

(ambeval '(define nouns '(noun student professor cat class))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
(ambeval '(define verbs '(verb studies lectures eats sleeps))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
(ambeval '(define articles '(article the a))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; We also need a grammar, that is, a set of rules describing how
;; grammatical elements are composed from simpler elements. A very
;; simple grammar might stipulate that a sentence always consists of
;; two pieces -- a noun phrase followed by a verb -- and that a noun
;; phrase consists of an article followed by a noun. With this
;; grammar, the sentence ``The cat eats'' is parsed as follows:

;; (sentence (noun-phrase (article the) (noun cat))
;;           (verb eats))

;; We can generate such a parse with a simple program that has separate
;; procedures for each of the grammatical rules. To parse a sentence,
;; we identify its two constituent pieces and return a list of these
;; two elements, tagged with the symbol sentence:

(ambeval '(define (parse-sentence)
            (list 'sentence
                  (parse-noun-phrase)
                  (parse-word verbs)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; A noun phrase, similarly, is parsed by finding an article followed by
;; a noun:

(ambeval '(define (parse-noun-phrase)
            (list 'noun-phrase
                  (parse-word articles)
                  (parse-word nouns)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; At the lowest level, parsing boils down to repeatedly checking that
;; the next unparsed word is a member of the list of words for the
;; required part of speech. To implement this, we maintain a global
;; variable *unparsed*, which is the input that has not yet been
;; parsed. Each time we check a word, we require that *unparsed* must
;; be non-empty and that it should begin with a word from the
;; designated list. If so, we remove that word from *unparsed* and
;; return the word together with its part of speech (which is found at
;; the head of the list)

(ambeval '(define (parse-word word-list)
            (require (not (null? *unparsed*)))
            (require (memq (car *unparsed*) (cdr word-list)))
            (let ((found-word (car *unparsed*)))
              (set! *unparsed* (cdr *unparsed*))
              (list (car word-list) found-word)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; To start the parsing, all we need to do is set *unparsed* to be the
;; entire input, try to parse a sentence, and check that nothing is
;; left over:

(ambeval '(define *unparsed* '())
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (parse input)
            (set! *unparsed* input)
            (let ((sent (parse-sentence)))
              (require (null? *unparsed*))
              sent))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; The amb evaluator is useful here because it is convenient to express
;; the parsing constraints with the aid of require. Automatic search
;; and backtracking really pay off, however, when we consider more
;; complex grammars where there are choices for how the units can be
;; decomposed.

(ambeval '(define prepositions '(prep for to in by with))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; and define a prepositional phrase (e.g., ``for the cat'') to be a
;; preposition followed by a noun phrase:

(ambeval '(define (parse-prepositional-phrase)
            (list 'prep-phrase
                  (parse-word prepositions)
                  (parse-noun-phrase)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; Now we can define a sentence to be a noun phrase followed by a verb
;; phrase, where a verb phrase can be either a verb or a verb phrase
;; extended by a prepositional phrase:52

(ambeval '(define (parse-sentence)
            (list 'sentence
                  (parse-noun-phrase)
                  (parse-verb-phrase)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (parse-verb-phrase)
            (define (maybe-extend verb-phrase)
              (amb verb-phrase
                   (maybe-extend (list 'verb-phrase
                                       verb-phrase
                                       (parse-prepositional-phrase)))))
            (maybe-extend (parse-word verbs)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

;; While we're at it, we can also elaborate the definition of noun
;; phrases to permit such things as ``a cat in the class.'' What we
;; used to call a noun phrase, we'll now call a simple noun phrase,
;; and a noun phrase will now be either a simple noun phrase or a noun
;; phrase extended by a prepositional phrase:

(ambeval '(define (parse-simple-noun-phrase)
            (list 'simple-noun-phrase
                  (parse-word articles)
                  (parse-word nouns)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))

(ambeval '(define (parse-noun-phrase)
            (define (maybe-extend noun-phrase)
              (amb noun-phrase
                   (maybe-extend (list 'noun-phrase
                                       noun-phrase
                                       (parse-prepositional-phrase)))))
            (maybe-extend (parse-simple-noun-phrase)))
         the-global-environment
         (lambda (value fail) value)
         (lambda () 'failed))
