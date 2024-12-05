(require "./attr.lisp") 

; Récupère la valeur à l'index `key` dans le tableau `tab`
(defun array-get(tab key)
  (aref tab key))

; Définit la valeur `val` à l'index `key` dans le tableau `tab`
(defun array-set(tab key val)
  (setf (aref tab key) val))

; Initialise un attribut `attr` de la VM avec un tableau de taille `size`
(defun attr-array-init(vm attr size)
  (attr-set vm attr (make-array size)))

; Récupère la valeur à l'index `key` dans le tableau associé à l'attribut `attr` de la VM
(defun attr-array-get(vm attr key)
  (array-get (attr-get vm attr) key))

; Définit la valeur `val` à l'index `key` dans le tableau associé à l'attribut `attr` de la VM
(defun attr-array-set(vm attr key val)
  (array-set (attr-get vm attr) key val))