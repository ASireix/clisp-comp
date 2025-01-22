(load "vm-registers.lisp")
(load "vm-memory.lisp")
(load "vm-core.lisp")
(load "vm-instructions.lisp")
(load "vm-loader.lisp")
(load "vm-runner.lisp")
(load "vm-utils.lisp")

(defparameter *current-vm* (vm-make :memory-size 1024 :name "Test VM"))

;; Charger un programme
(vm-load '((LOAD 10 R0) (ADD R1 R0) (HALT)))

;; Exécuter le programme
(print (vm-run))
