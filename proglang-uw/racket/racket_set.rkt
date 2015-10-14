#lang racket

(define x 3)
(set! x 2)

(begin (+ x 5))