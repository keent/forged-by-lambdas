
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below


; add me on github.com/keent :)

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))


(define (string-append-map xs suffix)
  (map (lambda (string) (string-append string suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(empty? xs) (error "list-nth-mod: empty list")]
        [#t (let* ([i (remainder n (length xs))]
              [iTH (car (list-tail xs i))])
              iTH)]))
            
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

(define funny-number-stream
  (letrec ([negateIfFiveDiv (lambda (y) (if (= (modulo y 5) 0) (* y -1) y))]
           [f (lambda (x) (cons (negateIfFiveDiv x) (lambda () (f (+ x 1)))))])
  (lambda () (f 1))))

(define dan-then-dog
  (letrec ([alternateStr (lambda (y) (if (string=? y "dan.jpg") "dog.jpg" "dan.jpg"))]
           [f (lambda (x) (cons x (lambda () (f (alternateStr x)))))])
  (lambda () (f "dan.jpg"))))

(define (stream-add-zero s)
  (letrec ([f (lambda (s) (cons (cons 0 (car (s))) (lambda () (f (cdr (s))))))])
    (lambda () (f s))))
  
(define (cycle-lists xs ys)
  (letrec ([f (lambda (xs ys xc yc) (cons (cons (list-nth-mod xs xc) (list-nth-mod ys yc)) 
                                    (lambda () (f xs ys (+ xc 1) (+ yc 1)))))])
    (lambda () (f xs ys 0 0))))

(define (vector-assoc v vec)
  (cond [(not (vector? vec)) (error "2nd argument not a vector")]
        [#t (letrec ([trav (lambda (pos) 
                            (cond [(>= pos (vector-length vec)) #f]
                                  [(not (pair? (vector-ref vec pos))) (trav (+ pos 1))]
                                  [(equal? (car (vector-ref vec pos)) v) (vector-ref vec pos)]
                                  [#t (trav (+ pos 1))] ) )] ) (trav 0))]))

(define (cached-assoc xs n)
  (letrec([memo (make-vector n #f)]
          [nextSlot 0]
          [f (lambda (v)
               (let ([ans (vector-assoc v memo)])
                 (if ans
                     (cdr ans)
                     (let ([new-ans (assoc v xs)])
                       (if new-ans
                           (begin
                             (vector-set! memo nextSlot new-ans)
                             (set! nextSlot (+ nextSlot 1))
                             (if (>= nextSlot n) (set! nextSlot 0) nextSlot)
                             new-ans)
                       new-ans
                       )))))])
    f ))
                           