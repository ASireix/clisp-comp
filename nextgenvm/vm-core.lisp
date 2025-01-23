(defstruct vm
  memory         ; Mémoire
  registers      ; Registres
  flags          ; Drapeaux
  pc             ; Compteur de programme
  sp             ; Pointeur de pile
  bp             ; Base de la pile
  fp             ; Frame pointer
  symbol-table   ; Résolution des étiquettes
  running        ; État de la VM
  loaded-code    ; Instructions chargées
  name)          ; Nom de la VM

(defun vm-make (&key (memory-size 1024) (name "default-vm"))
  "Crée une machine virtuelle."
  (make-vm
   :memory (make-array memory-size :initial-element 0)
   :registers (initialize-registers)
   :flags (initialize-flags)
   :pc 0
   :sp 0
   :bp memory-size
   :fp memory-size
   :symbol-table (make-hash-table :test 'equal)
   :running t
   :loaded-code nil
   :name name))
