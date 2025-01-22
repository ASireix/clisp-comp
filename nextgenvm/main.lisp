(load "vm-registers.lisp")
(load "vm-memory.lisp")
(load "vm-core.lisp")
(load "vm-instructions.lisp")
(load "vm-loader.lisp")
(load "vm-runner.lisp")
(load "vm-utils.lisp")

(defparameter *current-vm* (vm-make :memory-size 1024 :name "Test VM"))
(print-registers *current-vm*)
(mem-write *current-vm* 20 10) ;; Écrit 10 à l'adresse 20
(vm-load '((LOAD 20 R0)         ;; Charge 10 de l'adresse 20 dans R0
           (ADD (:CONST 5) R0)  ;; Ajoute 5 à R0
           (HALT)))             ;; Arrête la machine
(vm-run)
(print-registers *current-vm*)