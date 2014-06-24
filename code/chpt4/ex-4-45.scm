;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                    Author : ZhHy
;;                    Date   : 2010-09-06
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4.45
;;
;; With the grammar given above, the following sentence can be parsed
;; in five different ways: ``The professor lectures to the student in
;; the class with the cat.'' Give the five parses and explain the
;; differences in shades of meaning among them.
;;
;; =============================================================================

;; ANSWER:
;; the professor with the cat
;; the professor in the class
'(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase (verb-phrase (verb-phrase
                             (verb lectures)
                             (prep-phrase
                              (prep to) (simple-noun-phrase
                                         (article the) (noun student))))
                            (prep-phrase
                             (prep in) (simple-noun-phrase
                                        (article the) (noun class))))
               (prep-phrase
                (prep with) (simple-noun-phrase
                             (article the) (noun cat)))))

;; the professor in the class
;; the class with the cat
'(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase (verb-phrase
                (verb lectures)
                (prep-phrase
                 (prep to)
                 (simple-noun-phrase (article the) (noun student))))
               (prep-phrase
                (prep in)
                (noun-phrase (simple-noun-phrase (article the) (noun class))
                             (prep-phrase
                              (prep with)
                              (simple-noun-phrase
                               (article the) (noun cat)))))))

;; the professor with the cat
;; the student in the class
'(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase (verb-phrase (verb lectures)
                            (prep-phrase
                             (prep to)
                             (noun-phrase (simple-noun-phrase
                                           (article the) (noun student))
                                          (prep-phrase
                                           (prep in)
                                           (simple-noun-phrase
                                            (article the) (noun class))))))
               (prep-phrase
                (prep with) (simple-noun-phrase (article the) (noun cat)))))

;; the student with the cat
;; the student in the class
'(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
   (verb lectures)
   (prep-phrase
    (prep to)
    (noun-phrase
     (noun-phrase
      (simple-noun-phrase (article the) (noun student))
      (prep-phrase
       (prep in)
       (simple-noun-phrase (article the) (noun class))))
     (prep-phrase
      (prep with)
      (simple-noun-phrase (article the) (noun cat)))))))

;; the student in the class
;; the class with the cat
'(sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb-phrase
   (verb lectures)
   (prep-phrase
    (prep to)
    (noun-phrase (simple-noun-phrase (article the) (noun student))
                 (prep-phrase (prep in)
                              (noun-phrase
                               (simple-noun-phrase (article the) (noun class))
                               (prep-phrase
                                (prep with)
                                (simple-noun-phrase
                                 (article the) (noun cat)))))))))
