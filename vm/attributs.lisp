(defun get_attr (vm attr)
    (get vm attr)
)

(defun set_attr (vm attr val)
    (setf (get vm attr) val)
)

(defun incr_attr (vm attr)
    (set_attr vm attr (+ (get_attr vm attr) 1))
)

(defun decr_attr (vm attr)
    (set_attr vm attr (- (get_attr vm attr) 1))
)

(defun is_attr (e)
    (member e (list :R0 :R1 :R2 :SP :BP :FP :PC :FLT :FEQ :FGT))
)
