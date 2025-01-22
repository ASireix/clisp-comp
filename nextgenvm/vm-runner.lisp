(defun vm-run (&key (main nil) (vm *current-vm*))
  "Lance la machine virtuelle à l'adresse spécifiée ou à la dernière adresse chargée."
  ;; Définit l'adresse de départ
  (let ((start (or main (get-last-loaded-address vm))))
    (set-register vm 'PC start)) ;; Initialise le compteur de programme
  ;; Boucle principale d'exécution
  (loop while (vm-running vm)
        do (let ((instr (mem-read vm (get-register vm 'PC))))
             (execute-instruction vm instr)
             (increment-register vm 'PC 1))) ;; Passe à l'instruction suivante
  ;; Retourne la valeur finale du registre R0
  (get-register vm 'R0))

(defun vm-apply (fn vm &rest args)
  "Applique une fonction fn déjà chargée dans la VM aux arguments args."
  ;; Charger les arguments dans la pile
  (dolist (arg args)
    (push vm arg))
  ;; Définir le PC à la fonction donnée
  (let ((address (resolve-symbol vm fn)))
    (set-register vm 'PC address)) ;; Met le PC à l'adresse de la fonction
  ;; Exécute la machine
  (vm-run :vm vm)
  ;; Retourne la valeur finale de R0
  (get-register vm 'R0))
