(require "vm/utils/attr.lisp")

(defun pc-get(vm)
  "Récupère la valeur du compteur de programme (PC) de la VM."
  (attr-get vm :PC))

(defun pc-set(vm val)
  "Définit la valeur du compteur de programme (PC) de la VM."
  (attr-set vm :PC val))

(defun pc-incr(vm)
  "Incrémente le compteur de programme (PC) de la VM."
  (pc-set vm (+ (pc-get vm) 1)))

(defun pc-decr(vm)
  "Décrémente le compteur de programme (PC) de la VM."
  (pc-set vm (- (pc-get vm) 1)))

(defun is-jmp (insn)
  "Vérifie si l'instruction est un saut."
  (if (member (first insn) '(JMP JSR JGT JGE JLT JLE JEQ JNE JTRUE JNIL))
      t
      nil))

(defun is-label(insn)
  "Vérifie si l'instruction est une étiquette."
  (equal (first insn) 'LABEL))

(defconstant +start-code-id+ 0)
(defconstant +last-code-id+ 1)
(defconstant +etiq-id+ 2)
(defconstant +is-running-id+ 3)
(defconstant +ms-id+ 4)

(defun var-basse-get (vm id)
  "Récupère la valeur d'une variable basse de la VM."
  (mem-get vm id))

(defun var-basse-set (vm id val)
  "Définit la valeur d'une variable basse de la VM."
  (mem-set vm id val))

(defun is-running(vm)
  "Vérifie si la VM est en cours d'exécution."
  (equal (var-basse-get vm +is-running-id+) 1))

(defun set-running(vm val)
  "Définit l'état de la VM (en cours d'exécution ou non)."
  (var-basse-set vm +is-running-id+ val))

(defun ms-get(vm)
  "Récupère la valeur de la mémoire de la VM."
  (var-basse-get vm +ms-id+))

(defun ms-set(vm val)
  "Définit la valeur de la mémoire de la VM."
  (var-basse-set vm +ms-id+ val))

(defun update-labels-for-jumps (vm)
  "Met à jour les étiquettes pour les sauts dans la VM."
  (let ((etiq-table (etiq-get-table vm))
        (last-code (var-basse-get vm +last-code-id+))
        (pc (pc-get vm)))
    (loop for addr from last-code to pc do
      (let ((insn (mem-get vm addr)))
        (when (and insn (is-jmp insn) (or (symbolp (second insn)) (stringp (second insn))))
          (let ((label (second insn)))
            (let ((label-addr (etiq-get vm label)))
              (if label-addr
                (mem-set vm addr (list (first insn) label-addr))))))))))

(defun etiq-get-table (vm)
  "Récupère la table des étiquettes de la VM."
  (var-basse-get vm +etiq-id+))

(defun etiq-get (vm label)
  "Récupère l'adresse associée à une étiquette dans la VM."
  (gethash (string label) (etiq-get-table vm)))

(defun etiq-set (vm label addr)
  "Définit l'adresse associée à une étiquette dans la VM."
  (let ((etiq-table (etiq-get-table vm)))
    (setf (gethash (string label) etiq-table) addr)))

(defun is-etiq-set (vm label)
  "Vérifie si une étiquette est définie dans la VM."
  (let ((etiq-table (etiq-get-table vm)))
    (if (gethash (string label) etiq-table)
        t
        nil)))

(defun stack-get (vm)
  "Récupère la pile de la VM."
  (let ((bp (attr-get vm :BP))  ; Récupère la valeur de BP
        (sp (attr-get vm :SP))  ; Récupère la valeur de SP
        (mem (attr-get vm :mem)))  ; Récupère la mémoire complète
    (subseq mem (+ bp 1) (1+ sp))))  ; Renvoie la partie de la mémoire de BP à SP inclus

;--------------------------------------------------------------------------------------
(defun jsr (vm addr)
  "Effectue un saut vers une sous-routine en sauvegardant l'adresse de retour."
  (let ((pc (pc-get vm)))
    (push pc (attr-get vm :stack)) ; Empile l'adresse de retour avant les paramètres
    (pc-set vm addr)))

(defun ret (vm)
  "Retourne de la sous-routine en récupérant l'adresse de retour."
  (let ((stack (attr-get vm :stack)))
    (pc-set vm (pop stack))))

(defun jmp (vm addr)
  "Effectue un saut inconditionnel à l'adresse spécifiée."
  (pc-set vm addr))