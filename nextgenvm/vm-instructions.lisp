(defun vm-store (vm src dest)
  (let ((value (get-register vm src)))
    (mem-write vm dest value)))

(defun vm-load (vm src dest)
  (let ((value (if (numberp src)
                   (mem-read vm src)
                   (get-register vm src))))
    (set-register vm dest value)))

(defun vm-add (vm src dest)
  (let ((result (+ (get-register vm src) (get-register vm dest))))
    (set-register vm dest result)))

(defun vm-sub (vm src dest))

(defun vm-sub (vm src dest))

(defun vm-sub (vm src dest))

(defun vm-sub (vm src dest))
