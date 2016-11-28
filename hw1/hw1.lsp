(defun TREE-CONTAINS (N TREE)
  (cond ((null TREE) NIL)
        ((numberp TREE) (equal N TREE))
        ((equal (second TREE) N) T)
        ((< N (second TREE)) (TREE-CONTAINS N (first TREE)))
        ((> N (second TREE)) (TREE-CONTAINS N (third TREE)))))

(defun TREE-MAX (TREE)
  (cond ((null TREE) NIL)
        ((numberp TREE) TREE)
        ((null (third TREE)) (second TREE))
        (T (TREE-MAX (third TREE)))
        ))

(defun TREE-ORDER (TREE)
  (cond ((null TREE) NIL)
    	((numberp TREE) (list TREE))
        (T (append (TREE-ORDER (first TREE)) (cons (second TREE) (TREE-ORDER (third TREE)))))
   ))

(defun SUB-LIST (L START LEN)
  (cond ((null L) NIL)
        ((= LEN 0) NIL)
        ((= START 0) (cons (first L) (SUB-LIST (rest L) 0 (- LEN 1))))
        (T (SUB-LIST (rest L) (- START 1) LEN))
   ))

(defun SPLIT-LIST (L)
  (cond ((null L) NIL)
      ((oddp (length L)) (list (SUB-LIST L 0 (/ (- (length L) 1) 2)) (SUB-LIST L (/ (- (length L) 1) 2) (/ (+ (length L) 1) 2))))
        (T (list (SUB-LIST L 0 (/ (length L) 2)) (SUB-LIST L (/ (length L) 2) (/ (length L) 2))))
  )
)

(defun BTREE-HEIGHT (TREE)
  (cond 
        ((atom TREE) 0)
        (T (let ((left (+ 1 (BTREE-HEIGHT (first TREE))))
                (right (+ 1 (BTREE-HEIGHT (second TREE)))))
                (cond ((< left right) right)
                      (T left))
           )
        )
  ))

(defun LIST2BTREE (LEAVES)
  (cond ((null LEAVES) NIL)
        ((equal 1 (length LEAVES)) (first LEAVES))
        ((equal 2 (length LEAVES)) LEAVES)
        (T (let ((splitted (SPLIT-LIST LEAVES)))
            (list (LIST2BTREE (first splitted)) (LIST2BTREE (second splitted)))
           )
        )
  ))

(defun BTREE2LIST (TREE)
  (cond ((atom TREE) (list TREE))
        (T (append (BTREE2LIST (first TREE)) (BTREE2LIST (second TREE))))
  )
)

(defun IS-SAME (E1 E2)
  (cond ((and (numberp E1) (numberp E2)) (= E1 E2))
        ((and (not (numberp E1)) (numberp E2)) NIL)
        ((and (numberp E1) (not (numberp E2))) NIL)
        ((and (not E1) (not E2)) T) 
        ((IS-SAME (first E1) (first E2)) (IS-SAME (rest E1) (rest E2)))
        (T NIL)
  )
)

