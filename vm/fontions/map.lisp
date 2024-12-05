(require "./attr.lisp")

;définit la valeur `val` à l'index `key` dans le tableau `tab`
(defun map-set(tab key val)
  (setf (gethash key tab) val))
;récupère la valeur à l'index `key` dans le tableau `tab`
(defun map-get(tab key)
  (gethash key tab))
;initialise un attribut `attr` de la VM avec un tableau de taille `size`
(defun attr-map-init(vm attr size)
  (attr-set vm attr (make-hash-table :size size)))
;récupère la valeur à l'index `key` dans le tableau associé à l'attribut `attr` de la VM
(defun attr-map-get(vm attr key)
  (map-get (attr-get vm attr) key))
;définit la valeur `val` à l'index `key` dans le tableau associé à l'attribut `attr` de la VM
(defun attr-map-set(vm attr key val)
  (map-set (attr-get vm attr) key val))
