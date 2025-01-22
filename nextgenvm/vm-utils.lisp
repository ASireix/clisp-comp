(defun print-registers (vm)
  "Affiche les registres de la VM."
  (format t "R0: ~A, R1: ~A, R2: ~A~%"
          (get-register vm 'R0)
          (get-register vm 'R1)
          (get-register vm 'R2)))
(print-registers *current-vm*)