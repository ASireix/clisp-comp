(defun initialize-registers ()
  "Crée une table des registres (R0, R1, R2, etc.)."
  (let ((registers (make-hash-table :test 'equal)))
    (setf (gethash 'R0 registers) 0
          (gethash 'R1 registers) 0
          (gethash 'R2 registers) 0)
    registers))

(defun initialize-flags ()
  "Crée une table des drapeaux (FLT, FEQ, FGT)."
  (let ((flags (make-hash-table :test 'equal)))
    (setf (gethash 'FLT flags) nil
          (gethash 'FEQ flags) nil
          (gethash 'FGT flags) nil)
    flags))

(defun get-register (vm reg)
  "Renvoie la valeur d’un registre donné."
  (gethash reg (vm-registers vm)))

(defun set-register (vm reg value)
  "Modifie la valeur d’un registre donné."
  (setf (gethash reg (vm-registers vm)) value))
