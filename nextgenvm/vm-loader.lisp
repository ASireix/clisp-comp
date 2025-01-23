(defun vm-load (code &key (vm *current-vm*))
  "Charge une liste d'instructions dans la VM."
  (unless vm
    (error "Aucune machine virtuelle spécifiée."))
  (let ((address 0))
    ;; Première passe : enregistrer les labels
    (dolist (instruction code)
      (when (and (listp instruction) (eq (first instruction) 'LABEL))
        (etiq-set vm (second instruction) address))
      (when (not (eq (first instruction) 'LABEL))
        (incf address)))
    ;; Deuxième passe : charger les instructions
    (setf address 0)
    (dolist (instruction code)
      (unless (and (listp instruction) (eq (first instruction) 'LABEL))
        (mem-write vm address instruction)
        (incf address)))))
