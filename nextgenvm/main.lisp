(load "vm-registers.lisp")
(load "vm-memory.lisp")
(load "vm-core.lisp")
(load "vm-instructions.lisp")
(load "vm-loader.lisp")
(load "vm-runner.lisp")
(load "vm-utils.lisp")

(defparameter *current-vm* (vm-make :memory-size 1024 :name "Test VM"))
(print-registers *current-vm*)
(vm-load '((LOAD (:CONST 10) R0)  ;; Charge 10 dans R0
           (CMP R0 (:CONST 5))    ;; Compare R0 à 5
           (JGT 10)               ;; Saute à l’instruction 10 si R0 > 5
           (HALT)
           (LOAD (:CONST 42) R1)  ;; Instruction cible : Charge 42 dans R1
           (HALT)))
(vm-run)
(print-registers *current-vm*) ;; R1 devrait contenir 42
