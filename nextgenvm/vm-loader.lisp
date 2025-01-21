(defun vm-load-program (vm program)
  (loop for instr in program
        for addr from 0
        do (mem-write vm addr instr)))
