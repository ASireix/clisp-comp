(defun mem-read (vm address)
  (aref (vm-memory vm) address))

(defun mem-write (vm address value)
  (setf (aref (vm-memory vm) address) value))

(defun push-sp (vm value)
  (decf (vm-sp vm))
  (mem-write vm (vm-sp vm) value))

(defun pop-sp (vm)
  (let ((value (mem-read vm (vm-sp vm))))
    (incf (vm-sp vm))
    value))
