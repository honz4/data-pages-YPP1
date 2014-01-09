(define count-atoms
  (lambda (s)
    (cond ((null? s) 0)
          ((pair? s) (+ (count-atoms (car s))
                        (count-atoms (cdr s))))
          (else 1))))

(count-atoms '(a . (b . c)))

(define pokus
  (let* ((x (cons 1 2))
         (y (cons x x)))
    y))
  

(define count-atoms-pom
  (lambda (s found)
    (cond ((null? s) (cons 0 found))
          ((pair? s)
           (let* ((count-car (count-atoms-pom 
                              (car s)
                              found))
                  (count-cdr (count-atoms-pom 
                              (cdr s)
                              (cdr count-car))))
            (cons
             (+ (car count-car)
                (car count-cdr))                
             (cons s (cdr count-cdr)))))
          (else (cons 1 found)))))

(member 
        5
        '(1 2 3 4))


(member (cons 1 2) (list (cons 0 1) (cons 1 2)))

(equal? (cons 1 2) (cons  1 2))
(eqv? (cons 1 2) (cons  1 2))

(define member-eqv
  (lambda (e l)
    (cond ((null? l) #f)
          ((eqv? e (car l)) l)
          (else (member-eqv e (cdr l))))))
    
;(count-atoms-pom pokus ())
(member-eqv (cons 1 2) (list (cons 0 1) (cons 1 2)))
(let ((x (cons 1 2)))
  (member-eqv x (list (cons 0 1) x)))

(let ((x (cons 1 2)))
  (memv x (list (cons 0 1) x)))
      
           
(define count-atoms-pom
  (lambda (s found)
    (cond ((or (null? s)
               (and (pair? s) (member-eqv s found)))
           (cons 0 found))
          ((pair? s)
           (let* ((count-car (count-atoms-pom 
                              (car s)
                              found))
                  (count-cdr (count-atoms-pom 
                              (cdr s)
                              (cdr count-car))))
            (cons
             (+ (car count-car)
                (car count-cdr))                
             (cons s (cdr count-cdr)))))
          (else (cons 1 found)))))

(count-atoms-pom pokus ())
(count-atoms-pom '((1 . 2) . (1 . 2)) ())
           
(define 
  all-subsets
  (lambda (s)
    (if (null? s) '(())
        (let ((bez-prvniho (all-subsets (cdr s))))
          (append 
          
           (map (lambda(e)
                  (cons (car s) e))
                bez-prvniho)
            bez-prvniho
           )))))

(all-subsets '(1 2 3))

(quote (1 2 3))

(quasiquote (1 (+ 1 2) 3))

(quasiquote (1 (unquote (list + 1 2)) xxxx))
(quasiquote (1 (unquote-splicing (list + 1 2)) xxxx))

(define x '(1 2 3))
(define y '(a b c))
'xxxx
`(1 (unquote (list + 1 2)) xxxx)
`(1 ,(list + 1 2) xxxx)
(quasiquote (1 ,@(list + 1 2) xxxx))

`(,@x ,@y)

(when (< 3 4)
  (display "1 ")
  (+ 1 2))

(if (< 3 4)
    (let ()
      (display "1 ")
      (+ 1 2)))

(define when-t
  (lambda (c . n)
    `(if ,c (let () ,@n)))) 

(when-t '(< 3 4)
  '(display "1 ")
  '(+ 1 2))


(define-macro when-t
  (lambda (c . n)
    `(if ,c (let () ,@n)))) 
'xx
(when-t (< 3 4)
  (display "1 ")
  (+ 1 2))

(define muj-let
  (lambda (dvojice . telo)
    `((lambda ,(map car dvojice)
        ,@telo)
      ,@(map cadr dvojice))))

(muj-let '((x 10) (y 20)) '(+ x y))

(define-macro muj-let
  (lambda (dvojice . telo)
    `((lambda ,(map car dvojice)
        ,@telo)
      ,@(map cadr dvojice))))


(define-macro muj-let
  (lambda (dvojice . telo)
    (cons
     (cons 'lambda (cons (map car dvojice)
                         telo))
      (map cadr dvojice))))


(muj-let ((x 10)
          (y 20))
         (+ x y))

;muj-let

(define and-t
  (lambda n
    (cond ((null? n) #t)
          ((null? (cdr n)) (car n))
          (else
           `(if ,(car n)
                ,(apply and-t (cdr n))
                #f)))))

(and-t )
(and-t 's1)
(and-t 's1  '(< 2 1) 's3)
        

;(cykli-pro i od 1 do 10 delej (display i))

(let iter ((i 1))
  (if (<= i 10)
      (let ()
        (display i)
        (iter (+ i 1)))))

(define cykli-pro 
  (lambda (promenna od spodni do horni delej co-mam-delat)
    `(let iter ((,promenna ,spodni))
       (if (<= ,promenna ,horni)
           (let ()
             ,co-mam-delat
             (iter (+ ,promenna 1)))))))
(newline)
(cykli-pro 'i 'od '1 'do '10 'delej '(display i))

(define-macro cykli-pro 
  (lambda (promenna od spodni do horni delej co-mam-delat)
    (when (not (equal? delej 'delej))
      (error "sorry, error"))
    `(let iter ((,promenna ,spodni))
       (if (<= ,promenna ,horni)
           (let ()
             ,co-mam-delat
             (iter (+ ,promenna 1)))))))

;(cykli-pro i od 1 do 10 nedelej (display i))

(define strom
  '(5 .
      ((3 .
          (() . (4 . (() . ())))) .
       (6 . (() . ())))))



(define left cadr)
(define right cddr)
(define key car)



(define search-tree
  (lambda (k tree)
    (cond ((null? tree) #f)
          ((equal? (key tree)
                   k) tree)
          ((< k (key tree)) (search-tree k (left tree)))
          (else (search-tree k (right tree))))))
    
(search-tree 6 strom)

(define make-node
  (lambda (key l p)
    `(,key . (,l . ,p))))

(define add-node
  (lambda (k tree)
    (display tree)
    (cond ((null? tree) (make-node k () ()))
          ((equal? (key tree)
                   k) tree)
          ((< k (key tree)) 
           
           (make-node
            (key tree)
            (add-node k (left tree))
            (right tree)))
           
          (else 
           (make-node
            (key tree)
            (left tree)
            (add-node k (right tree)))))))

(foldl (lambda(x a)
         (add-node x a))
       ()
       '(5 3 4 6))

