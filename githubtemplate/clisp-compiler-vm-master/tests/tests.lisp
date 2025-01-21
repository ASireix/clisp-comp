(load "tests/fonctions.lisp")

;; Création d'une machine virtuelle dédiée aux tests.

(setf mv 'mvtest)
(make-machine mv 5000 T)


;; Tests arithmétiques.

(load "tests/tests/operations.lisp")


;; Tests d'opérateurs booléens.

(load "tests/tests/booleens.lisp")


;; Tests de boucles de condition.

(load "tests/tests/conditions.lisp")


;; Tests de fonctions.

(load "tests/tests/fonctions.lisp")


;; Tests de structures de contrôle.

(load "tests/tests/structures.lisp")


;; Tests de fonctions classiques.

(load "tests/tests/classiques.lisp")
