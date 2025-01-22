(defun vm-load (code &key (vm *current-vm*))
  ;; Résolution des étiquettes et chargement des instructions
  (let ((address 0)) ;; Commence à l'adresse 0 par défaut
    (dolist (instruction code)
      (mem-write vm address instruction) ;; Écrit l'instruction en mémoire
      (incf address)))
  (when (chargeur-charge? vm)
    (vm-run :vm vm)))
