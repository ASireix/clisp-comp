(require "vm/utils/array.lisp")

;récupère l'index key de la mémoire de la VM
(defun mem-get(vm key)
  (attr-array-get vm :MEM key))
; définit la valeur val à l'index key de la mémoire de la VM
(defun mem-set(vm key val)
  (attr-array-set vm :MEM key val))
; vérifie si val est une constante
(defun is-const(val)
  (and (listp val) (equal (first val) :CONST)))
; si var est une var globale 
(defun is-global-var(val)
  (and (listp val) (equal (first val) :@)))
; si var est une décalage
(defun is-offset(val)
  (and (listp val) (equal (string (first val)) '"+") (symbolp (second val))))
