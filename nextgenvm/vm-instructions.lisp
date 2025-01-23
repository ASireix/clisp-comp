(defun vm-store (vm src dest)
  (let ((value (get-register vm src)))
    (mem-write vm dest value)))

(defun vm-load-inst (vm src dest)
  (let ((value (cond
                 ((and (listp src) (eq (first src) :CONST)) (second src))  ;; Si c'est une constante
                 ((numberp src) (mem-read vm src))         ;; Si c'est une adresse mémoire
                 (t (get-register vm src)))))              ;; Sinon, c'est un registre
    (set-register vm dest value)))

(defun vm-move (vm src dest)
  "Déplace une valeur d'un registre ou d'une mémoire à un autre registre ou emplacement mémoire."
  (let ((src-value (cond
                     ((and (listp src) (eq (first src) :CONST)) (second src))   ;; Gestion des constantes
                     ((numberp src) (mem-read vm src))        ;; Adresse mémoire
                     (t (get-register vm src)))))             ;; Registre
    (cond
      ((symbolp dest) (set-register vm dest src-value))  ;; Déplacer vers un registre
      ((numberp dest) (mem-write vm dest src-value))     ;; Déplacer vers une adresse mémoire
      (t (error "Destination inconnue pour vm-move: ~A" dest)))))

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
    (format t "Jump vers ~A (adresse ~A)~%" label address) ;; Trace
    (pc-set vm address)))
    
(defun vm-cmp (vm src dest)
  (let* ((src-val (get-register vm src))
         (dest-val (get-register vm dest))
         (result (- src-val dest-val)))
    ;; Mettre à jour les drapeaux en fonction de la comparaison
    (attr-set vm 'FLT (< src-val dest-val))  ;; FLT : vrai si src < dest
    (attr-set vm 'FEQ (= src-val dest-val)) ;; FEQ : vrai si src == dest
    (attr-set vm 'FGT (> src-val dest-val)))) ;; FGT : vrai si src > dest
    ;;changer les bons drapeaux

(defun vm-jsr (vm label)
  (let ((address (etiq-get vm label)))
    (stack-push vm (pc-get vm))
    (pc-set vm address)))

;;remplacer :cmp par le bon drapeaux
(defun vm-jge (vm label)
  ;; JGE : Jump si Greater ou Equal (FGT ou FEQ est vrai)
  (when (or (attr-get vm 'FGT) (attr-get vm 'FEQ))
    (vm-jmp vm label)))

(defun vm-jlt (vm label)
  ;; JLT : Jump si Less Than (FLT est vrai)
  (when (attr-get vm 'FLT)
    (vm-jmp vm label)))

(defun vm-jgt (vm label)
  ;; JGT : Jump si Greater Than (FGT est vrai)
  (when (attr-get vm 'FGT)
    (vm-jmp vm label)))

(defun vm-jle (vm label)
  ;; JLE : Jump si Less ou Equal (FLT ou FEQ est vrai)
  (when (or (attr-get vm 'FLT) (attr-get vm 'FEQ))
    (vm-jmp vm label)))

(defun vm-jeq (vm label)
  ;; JEQ : Jump si Equal (FEQ est vrai)
  (when (attr-get vm 'FEQ)
    (vm-jmp vm label)))

(defun vm-jne (vm label)
  ;; JNE : Jump si Not Equal (ni FLT ni FGT, donc pas FEQ)
  (when (not (attr-get vm 'FEQ))
    (vm-jmp vm label)))

(defun vm-test (vm src)
  ;; TEST : Vérifie si la valeur dans src est zéro ou non
  (if (zerop (get-register vm src))
      (progn
        ;; Si zéro : définir drapeaux à Equal
        (attr-set vm 'FLT nil)
        (attr-set vm 'FEQ t)
        (attr-set vm 'FGT nil))
      (progn
        ;; Sinon : définir drapeaux à Greater (valeur non nulle positive par défaut)
        (attr-set vm 'FLT nil)
        (attr-set vm 'FEQ nil)
        (attr-set vm 'FGT t))))


(defun vm-jnil (vm label)
  (when (zerop (get-register vm :R0))
    (vm-jmp vm label)))

(defun vm-jtrue (vm label)
  (when (not (zerop (get-register vm :R0)))
    (vm-jmp vm label)))

(defun vm-label (vm label)
  (etiq-set vm label (pc-get vm)))