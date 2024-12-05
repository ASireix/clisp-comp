(defun is_const (e)
    (eql (car e) :CONST)
)

(defun is_index (e)
    (numberp (car e))
)