(defun vm-load (code &key (vm *current-vm*))
  "Charge une liste d'instructions dans la VM."
  (unless vm
    (error "Aucune machine virtuelle spécifiée."))
  (let ((address 0))
    (dolist (instruction code)
      (mem-write vm address instruction)
      (incf address)))
  (when (chargeur-charge? vm)
    (vm-apply 'chargeur-main vm)))