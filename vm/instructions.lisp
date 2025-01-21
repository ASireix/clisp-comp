(defun vm_load (vm src dest)
)

(defun vm_store (vm src dest)
)

(defun vm_move (vm src dest)
)

(defun vm_op (vm op src dest)
)

(defun vm_add (vm src dest)
    (vm_op vm '+ src dest)
)

(defun vm_sub (vm src dest)
    (vm-op vm `- src dest)
)

(defun vm_mul (vm src dest)
    (vm_op vm `* src dest)
)

(defun vm_div (vm src dest)
    (vm_op vm `/ src dest)
)

(defun vm_incr (vm dest)
    (vm_add vm `(:CONST 1) dest)
)

(defun vm_decr (vm dest)
    (vm_sub vm `(:CONST 1) dest)
)

(defun vm_label (vm label)

)

(defun vm_jmp (vm label)

)

