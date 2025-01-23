(load "vm-registers.lisp")
(load "vm-memory.lisp")
(load "vm-core.lisp")
(load "vm-instructions.lisp")
(load "vm-loader.lisp")
(load "vm-runner.lisp")
(load "vm-utils.lisp")

(defparameter *current-vm* (vm-make :memory-size 1024 :name "Test VM"))
(mem-write *current-vm* 20 10)  ;; Écrit 10 à l'adresse 20
(vm-load '((LOAD (:CONST 20) R0)         ;; Charge 10 de l'adresse 20 dans R0
           (LOAD (:CONST 10) R0)
           (MOVE R0 R1)  ;; Ajoute 5 à R0
           (ADD (:CONST -1) R0)
           (CMP R0 R1)
           (CMP R1 R0)
           (HALT)))             ;; Arrête la machine
(vm-run)
(print-registers *current-vm*)