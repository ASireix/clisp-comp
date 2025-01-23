(defun vm-run (&key (main nil) (vm *current-vm*))
  ;"Lance la machine virtuelle à l'adresse spécifiée ou à la dernière adresse chargée."
  (let ((start (or main (get-last-loaded-address vm))))
    (pc-set vm start))
  (loop while (is-running vm)
        do (let ((instr (mem-read vm (pc-get vm))))
             (format t "PC: ~A~%" (pc-get vm)) ; Affiche la valeur de 'PC'
             (execute-instruction vm instr)
             (increment-pc vm 1)))
  (get-register vm 'R0))


(defun vm-apply (fn vm &rest args)
 ; "Applique une fonction fn déjà chargée dans la VM aux arguments args."
  (dolist (arg args)
    (stack-push vm arg))
  (let ((address (resolve-symbol vm fn)))
    (pc-set vm address))
  (vm-run :vm vm)
  (get-register vm 'R0))

(defun execute-instruction (vm instr)
  (case (first instr)
    (LOAD (vm-load-inst vm (second instr) (third instr)))
    (STORE (vm-store vm (second instr) (third instr)))
    (MOVE (vm-move vm (second instr) (third instr)))
    (ADD (vm-add vm (second instr) (third instr)))
    (SUB (vm-sub vm (second instr) (third instr)))
    (MUL (vm-mul vm (second instr) (third instr)))
    (DIV (vm-div vm (second instr) (third instr)))
    (INCR (vm-incr vm (second instr)))
    (DECR (vm-decr vm (second instr)))
    (PUSH (vm-push vm (second instr)))
    (POP (vm-pop vm (second instr)))
    (NOP (vm-nop vm))
    (HALT (vm-halt vm))
    (JMP (vm-jmp vm (second instr)))
    (CMP (vm-cmp vm (second instr) (third instr)))
    (JSR (vm-jsr vm (second instr)))
    (JGT (vm-jgt vm (second instr)))
    (JGE (vm-jge vm (second instr)))
    (JLT (vm-jlt vm (second instr)))
    (JLE (vm-jle vm (second instr)))
    (JEQ (vm-jeq vm (second instr)))
    (JNE (vm-jne vm (second instr)))
    (TEST (vm-test vm (second instr)))
    (JNIL (vm-jnil vm (second instr)))
    (JTRUE (vm-jtrue vm (second instr)))
    (LABEL (vm-label vm (second instr)))
    (t (format t "Instruction inconnue: ~A~%" instr))))

(defun chargeur-charge? (vm)
 ; "Vérifie si le chargeur est chargé dans la VM."
  (not (null (vm-loaded-code vm))))

(defun get-last-loaded-address (vm)
 ; "Retourne la dernière adresse chargée dans la mémoire de la VM."
  (let ((loaded-code (vm-loaded-code vm)))
    (if loaded-code
        (1- (length loaded-code))
        0)))

(defun resolve-symbol (vm fn)
 ; "Résout un symbole dans la table des symboles de la VM."
  (gethash fn (vm-symbol-table vm)))