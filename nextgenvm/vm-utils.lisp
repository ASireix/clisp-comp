(defun print-registers (vm)
  (format t "R0: ~A R1: ~A R2: ~A PC: ~A SP: ~A BP: ~A~%"
          (get-register vm 'R0)
          (get-register vm 'R1)
          (get-register vm 'R2)
          (get-register vm 'PC)
          (get-register vm 'SP)
          (get-register vm 'BP)))
