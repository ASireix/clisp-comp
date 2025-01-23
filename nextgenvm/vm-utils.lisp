(defun print-registers (vm)
  "Affiche les registres et les drapeaux de la VM."
  (format t "Registres - R0: ~A, R1: ~A, R2: ~A~%"
          (get-register vm 'R0)
          (get-register vm 'R1)
          (get-register vm 'R2))
  (format t "Flags - FLT: ~A, FEQ: ~A, FGT: ~A~%"
          (attr-get vm 'FLT)
          (attr-get vm 'FEQ)
          (attr-get vm 'FGT)))
(print-registers *current-vm*)