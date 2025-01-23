(defun mem-read (vm address)
  (aref (vm-memory vm) address))

(defun mem-write (vm address value)
  (setf (aref (vm-memory vm) address) value))

(defun stack-push (vm value)
  ;"Empile une valeur sur la pile de la VM."
  (decf (vm-sp vm))
  (mem-write vm (vm-sp vm) value))

(defun stack-pop (vm)
 ; "Dépile une valeur de la pile de la VM."
  (let ((value (mem-read vm (vm-sp vm))))
    (incf (vm-sp vm))
    value))

(defun is-running (vm)
  (vm-running vm))

(defun set-running (vm value)
  (setf (vm-running vm) value))

(defun etiq-get (vm label)
  (gethash label (vm-symbol-table vm)))

(defun etiq-set (vm label address)
  (setf (gethash label (vm-symbol-table vm)) address))

(defun pc-set (vm address)
  (setf (vm-pc vm) address))

(defun pc-get (vm)
  (vm-pc vm))

(defun attr-set (vm attr value)
  (setf (gethash attr (vm-flags vm)) value))

(defun attr-get (vm attr)
  (gethash attr (vm-flags vm)))

(defun increment-register (vm reg value)
  (set-register vm reg (+ (get-register vm reg) value)))

(defun increment-pc (vm value)
  (pc-set vm (+ (pc-get vm) value))
)