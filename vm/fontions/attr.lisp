;récupère les valeurs de l'attribut `attr` de la VM
(defun attr-get(vm attr)
  (get vm attr))

; définit la valeur d=val pour l'attribut `attr` de la VM
(defun attr-set(vm attr val)
  (setf (get vm attr) val))