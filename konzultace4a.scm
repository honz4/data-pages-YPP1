#!/usr/bin/env racket
#lang racket/base

;;======fib======
(define fib
  (lambda (n)
    (if (<= n 1) n
        (+ (fib (- n 1))
           (fib (- n 2))))))

(build-list 10 fib)


(define fib-iter ;pomocna: global bind
  (lambda (f1 f2 i)
    (if (= i 0) f1
      (fib-iter f2 (+ f1 f2) (- i 1))))) ;tail pozice

(define fib2
  (lambda (n)
    (fib-iter 0 1 n)))

(build-list 10 fib2)

;;--------------------------------

(define fib3
  (lambda (n)

    (define fib-iter ;pomocna lokal bind, ale pokazde nova lambda!
      (lambda (f1 f2 i)
        (if (= i 0) f1
          (fib-iter f2 (+ f1 f2) (- i 1)))))

    (fib-iter 0 1 n)))



(define fib4
  (lambda (n)
    (letrec ((fib-iter-pomoci-letu
               (lambda (f1 f2 i)
                 (if (= i 0) f1
                   (fib-iter-pomoci-letu f2 (+ f1 f2) (- i 1))))))
      (fib-iter-pomoci-letu 0 1 n))))

(build-list 10 fib4)

(define fib5
    (letrec ((fib-iter-pomoci-letu
              (lambda (f1 f2 i)
                (if (= i 0) f1
                    (fib-iter-pomoci-letu f2 (+ f1 f2) (- i 1))))))
      (lambda (n)   
        (fib-iter-pomoci-letu 0 1 n))))


(build-list 10 fib5)

(define fib6
  (lambda (n)
    (let fib-iter-pomoci-letu ((f1 0)
                               (f2 1)
                               (i n))
      (if (= i 0) f1
          (fib-iter-pomoci-letu f2 (+ f1 f2) (- i 1))))))

(build-list 10 fib5)

(define s '((1 . 2) 3 ((4) . 5)))

;;======count-atoms======
(define count-atoms
  (lambda (s)
    (cond ((null? s) 0)
          ((pair? s) (+ (count-atoms (car s))
                        (count-atoms (cdr s))))
          (else 1))))

;;======atoms======
(define atoms
  (lambda (s)
    (cond ((null? s) '())
          ((pair? s) (append (atoms (car s))
                             (atoms (cdr s))))
          (else (list s)))))


(define x 
  (let ((alist (list 'a)))
    (cons alist alist)))
x
(count-atoms x)
(atoms x)

(define count-atoms2
  (lambda (l)
    (count-atoms2-pom l '())))

(define count-atoms2-pom
  ;; vraci par (count . found)
  (lambda (x found)
    (cond ((null? x) (cons 0 found))
          ((and (pair? x) (memv x found))
           (cons 0 found))
          ((pair? x)
           
      (let* ((newfound (cons x found))
             (atomscar (count-atoms2-pom (car x)
                                         newfound))
             (atomscdr (count-atoms2-pom (cdr x)
                                         (cdr atomscar)))
             (newcount (+ (car atomscar)
                          (car atomscdr)))
             (newfound (cdr atomscdr)))
        (cons newcount newfound)))
          (else (cons 1 found)))))
           
; vim: syntax=racket
