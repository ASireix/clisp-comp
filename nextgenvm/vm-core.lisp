(defstruct vm
  memory         ; Mémoire (vecteur)
  registers      ; Table des registres (R0, R1, R2, etc.)
  flags          ; Drapeaux (FLT, FEQ, FGT)
  pc             ; Compteur de programme (PC)
  sp             ; Pointeur de pile (SP)
  bp             ; Base de la pile (BP)
  fp             ; Frame pointer (FP)
  symbol-table   ; Table des étiquettes (résolution de labels)
  running        ; Booléen pour indiquer si la VM est active
  loaded-code    ; Instructions chargées en mémoire
  name)          ; Nom de la VM



(defun vm-make (&key (memory-size 1024) (name "default-vm"))
  "Crée une machine virtuelle avec une mémoire de la taille spécifiée et un nom."
  (make-vm
   :memory (make-array memory-size :initial-element 0) ; Mémoire initialisée à 0
   :registers (make-hash-table :test 'equal)          ; Table des registres
   :flags (make-hash-table :test 'equal)              ; Table des drapeaux
   :pc 0                                              ; Compteur de programme initialisé à 0
   :sp memory-size                                    ; Pile vide (SP pointe à la fin)
   :bp memory-size                                    ; Base de la pile initialisée
   :fp memory-size                                    ; Frame pointer initialisé
   :symbol-table (make-hash-table :test 'equal)       ; Table pour les étiquettes
   :running t                                         ; VM active par défaut
   :loaded-code nil                                   ; Aucun code chargé au départ
   :name name))                                       ; Définit le nom de la VM
