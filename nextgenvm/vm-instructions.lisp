(defun vm-store (vm src dest)
  (let ((value (get-register vm src)))
    (mem-write vm dest value)))

(defun vm-load-inst (vm src dest)
  (let ((value (cond
                 ((eq (first src) :CONST) (second src))   ;; Gestion des constantes
                 ((numberp src) (mem-read vm src))        ;; Adresse mémoire
                 (t (get-register vm src)))))            ;; Registre
    (set-register vm dest value)))


(defun vm-add (vm src dest)
  (let ((src-value (if (and (listp src) (eq (first src) :CONST))
                       (second src)                    ;; Valeur littérale
                       (get-register vm src)))         ;; Registre
        (dest-value (get-register vm dest)))
    (set-register vm dest (+ src-value dest-value))))


(defun vm-sub (vm src dest)
  (let ((result (- (get-register vm src) (get-register vm dest))))
    (set-register vm dest result)))

(defun vm-mul (vm src dest)
  (let ((result (* (get-register vm src) (get-register vm dest))))
    (set-register vm dest result)))

(defun vm-div (vm src dest)
  (let ((result (/ (get-register vm src) (get-register vm dest))))
    (set-register vm dest result)))

(defun vm-incr (vm src)
  (let ((result (+ (get-register vm src) 1)))
    (set-register vm src result)))

(defun vm-decr (vm src)
  (let ((result (- (get-register vm src) 1)))
    (set-register vm src result)))

(defun vm-push (vm src)
  (let ((value (if (numberp src)
                   src
                   (get-register vm src))))
    (stack-push vm value)))

(defun vm-pop (vm dest)
  (let ((value (stack-pop vm)))
    (set-register vm dest value)))

(defun vm-nop (vm)
  (format t "NOP~%"))

(defun vm-halt (vm)
  (set-running vm nil))

(defun vm-jmp (vm label)
  (let ((address (etiq-get vm label)))
    (pc-set vm address)))

(defun vm-cmp (vm src dest)
  (let ((src-value (if (and (listp src) (eq (first src) :CONST))
                       (second src)
                       (get-register vm src)))
        (dest-value (if (and (listp dest) (eq (first dest) :CONST))
                        (second dest)
                        (get-register vm dest))))
    (attr-set vm :cmp (- src-value dest-value))))


(defun vm-jsr (vm label)
  (let ((address (etiq-get vm label)))
    (stack-push vm (pc-get vm))
    (pc-set vm address)))

(defun vm-jge (vm label)
  (when (>= (attr-get vm :cmp) 0)
    (vm-jmp vm label)))

(defun vm-jlt (vm label)
  (when (< (attr-get vm :cmp) 0)
    (vm-jmp vm label)))

(defun vm-jgt (vm label)
  (when (> (attr-get vm :cmp) 0)
    (vm-jmp vm label)))

(defun vm-jle (vm label)
  (when (<= (attr-get vm :cmp) 0)
    (vm-jmp vm label)))

(defun vm-jeq (vm label)
  (when (= (attr-get vm :cmp) 0)
    (vm-jmp vm label)))

(defun vm-jne (vm label)
  (when (/= (attr-get vm :cmp) 0)
    (vm-jmp vm label)))

(defun vm-test (vm src)
  (if (zerop (get-register vm src))
      (attr-set vm :cmp 0)
      (attr-set vm :cmp 1)))

(defun vm-jnil (vm label)
  (when (zerop (get-register vm :R0))
    (vm-jmp vm label)))

(defun vm-jtrue (vm label)
  (when (not (zerop (get-register vm :R0)))
    (vm-jmp vm label)))

(defun vm-execute (vm)
  (loop while (is-running vm)
        do (let ((instr (mem-read vm (get-register vm 'PC))))
             (case (first instr)
               (LOAD (vm-load-inst vm (second instr) (third instr)))
               (STORE (vm-store vm (second instr) (third instr)))
               (ADD (vm-add vm (second instr) (third instr)))
               (SUB (vm-sub vm (second instr) (third instr)))
               (MUL (vm-mul vm (second instr) (third instr)))
               (DIV (vm-div vm (second instr) (third instr)))
               (INCR (vm-incr vm (second instr)))
               (DECR (vm-decr vm (second instr)))
               (PUSH (vm-push vm (second instr)))
               (POP (vm-pop vm (second instr)))
               (NOP (vm-nop vm))
               (HALT (vm-halt vm))
               (JMP (vm-jmp vm (second instr)))
               (CMP (vm-cmp vm (second instr) (third instr)))
               (JSR (vm-jsr vm (second instr)))
               (JGT (vm-jgt vm (second instr)))
               (JGE (vm-jge vm (second instr)))
               (JLT (vm-jlt vm (second instr)))
               (JLE (vm-jle vm (second instr)))
               (JEQ (vm-jeq vm (second instr)))
               (JNE (vm-jne vm (second instr)))
               (TEST (vm-test vm (second instr)))
               (JNIL (vm-jnil vm (second instr)))
               (JTRUE (vm-jtrue vm (second instr)))
               (t (format t "Instruction inconnue: ~A~%" instr)))
             (increment-register vm 'PC 1))))