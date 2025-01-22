(defun get-register (vm reg)
  (gethash reg (vm-registers vm)))

(defun set-register (vm reg value)
  (setf (gethash reg (vm-registers vm)) value))

(defun initialise-registers ()
  (let ((registers (make-hash-table :test `equal)))
    (setf (gethash 'R0 registers) 0
          (gethash 'R1 registers) 0
          (gethash 'R2 registers) 0
    )
  registers)
)

(defun set-flags (vm lt eq gt)
  (setf (gethash 'FLT (vm-flags vm)) lt)
  (setf (gethash 'FEQ (vm-flags vm)) eq)
  (setf (gethash 'FGT (vm-flags vm)) gt))
