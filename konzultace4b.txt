(define ! (lambda (n)
            (if (= n 0) 1
                (* n (! (- n 1))))))

(define !iter (lambda (a i)
                (if (= i 0) a
                    (!iter (* a i) (- i 1)))))

(define !* (lambda(n) (!iter 1 n)))

(define !iter (lambda (a i)
                
                (display "a: ")
                (display a)
                (newline)
                (display "i: ")
                (display i)
                (newline)
                (newline)
                (if (= i 0) a
                    (!iter (* a i) (- i 1)))))


(define merge
  (lambda (l1 l2  order)
    (cond ((null? l1) l2)
          ((null? l2) l1)
          ((order (car l1)
              (car l2))
           (cons (car l1) (merge (cdr l1)
                                 l2 order)))
          (else (cons (car l2) (merge (cdr l2)
                                 l1  order))))))
           

(define split
  (lambda (l)
    (split-pomocna l () ())))

(define split-pomocna
  (lambda (l l1 l2)
    
    (if (null? l) (cons l1 l2)
        (split-pomocna (cdr l)
                       (cons (car l) l2)
                       l1))))


(define mergesort
  (lambda (l order)
    (if (or (null? l) (null? (cdr l))) l
        (let* ((l1l2 (split l))
               (l1 (car l1l2))
               (l2 (cdr l1l2)))
          
          (merge (mergesort l1 order)
                 (mergesort l2 order) order)))))
          

(define abc-string "aábcčdďeéěfghiíjklmnňoópqrřsštťuůúvwxyýzž")

(define abc-assoc
  (let* ((lst (string->list abc-string))
         (len (length lst)))
    
    (map
     cons
     lst
     (build-list len +))))


(define my-assoc 
  (lambda (e l)
    (cond ((null? l) #f)
          ((equal? e (caar l)) (car l))
          (else (my-assoc e (cdr l))))))

(define my-assoc 
  (lambda (e l)
    (if (null? l) #f
        (if (equal? e (caar l)) (car l)
            (my-assoc e (cdr l))))))

(define index-of (lambda (c)
                   (cdr (my-assoc c abc-assoc))))

(define compare-strings-cz
  (lambda (s1 s2)
    (compare-strings-cz-aux 
     (string->list s1) 
     (string->list s2) 
     )))

(define compare-strings-cz-aux
  (lambda (l1 l2)
    (cond ((null? l1) #t)
          ((null? l2) #f)
          ((< (index-of (car l1))
              (index-of (car l2))) #t)
          ((> (index-of (car l1))
              (index-of (car l2))) #f)
          (else (compare-strings-cz-aux
                 (cdr l1)
                 (cdr l2))))))

(compare-strings-cz "svete" "áhoj" )

(mergesort '("ahoj" "člověče" "xxx" "ššš")
           compare-strings-cz)
                
          
     
     

            
                   
       
          







