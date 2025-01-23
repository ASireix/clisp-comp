(load "vm-registers.lisp")
(load "vm-memory.lisp")
(load "vm-core.lisp")
(load "vm-instructions.lisp")
(load "vm-loader.lisp")
(load "vm-runner.lisp")
(load "vm-utils.lisp")

(defparameter *current-vm* (vm-make :memory-size 1024 :name "Test VM"))
(vm-load '((LOAD (:CONST 10) R0)          ;; Charge 10 dans R0
           (LOAD (:CONST 20) R1)          ;; Charge 20 dans R1
           (CMP R0 R1)                    ;; Compare R0 et R1
           (JLT LESS)              ;; Si R0 < R1, saute à LABEL-LESS
           (LOAD (:CONST 100) R2)         ;; Sinon, charge 100 dans R2
           (JMP END)                     ;; Saute à la fin
           (LABEL LESS)                  ;; LABEL-LESS : si R0 < R1
           (LOAD (:CONST -1) R2)          ;; Charge -1 dans R2
           (LABEL END)                         ;; END : fin du programme
           (HALT)))                       ;; Arrête la machine
         ;; Arrête la machine
(vm-run)
(print-registers *current-vm*)