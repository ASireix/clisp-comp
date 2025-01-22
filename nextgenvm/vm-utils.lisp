(defun print-registers (vm)
  (format t "R0: ~A R1: ~A R2: ~A PC: ~A SP: ~A BP: ~A FP: ~A~%"
          (get-register vm 'R0)
          (get-register vm 'R1)
          (get-register vm 'R2)
          (get-register vm 'PC)
          (get-register vm 'SP)
          (get-register vm 'BP)
          (get-register vm 'FP)))

(let ((vm (vm-make :memory-size 512 :name "Test VM")))
  (print "Machine virtuelle créée.")
  (print (get-register vm 'PC)))

(let ((vm (vm-make)))
  (vm-load '((LOAD 10 R0) (ADD R0 R1) (HALT)) :vm vm)
  (vm-run :vm vm)
  (print (get-register vm 'R0))) ;; Affiche la valeur finale de R0

(let ((vm (vm-make)))
  (vm-load '((LOAD 0 R0) (ADD R0 R1) (HALT)) :vm vm)
  (print (vm-apply 'main vm 5 10))) ;; Applique "main" avec 5 et 10
