(defun get-register (vm reg)
  (gethash reg (vm-registers vm)))

(defun set-register (vm reg value)
  (setf (gethash reg (vm-registers vm)) value))

(defun set-flags (vm lt eq gt)
  (setf (gethash 'FLT (vm-flags vm)) lt)
  (setf (gethash 'FEQ (vm-flags vm)) eq)
  (setf (gethash 'FGT (vm-flags vm)) gt))
