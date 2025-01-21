(defun vm-make (memory-size)
  (make-vm :memory (make-array memory-size :initial-element 0)
           :registers (make-hash-table :test 'equal)
           :flags (make-hash-table :test 'equal)
           :pc 0
           :sp memory-size
           :bp memory-size
           :symbol-table (make-hash-table :test 'equal)
           :loaded-code nil))
