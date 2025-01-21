;; Gestion de tous les différents cas de compilation possibles / gérés.


;; Compilation de littéraux.

(load "compilateur/cas/litteraux.lisp")


;; Compilation d'opérations arithmétiques.

(load "compilateur/cas/operations.lisp")


;; Compilation d'opérateurs de comparaison.

(load "compilateur/cas/booleens.lisp")


;; Compilation de structures de condition.

(load "compilateur/cas/conditions.lisp")


;; Compilation de structures itératives.

(load "compilateur/cas/boucles.lisp")


;; Compilation de fonctions.

(load "compilateur/cas/fonctions.lisp")


;; Compilation des déclarations de variables.

(load "compilateur/cas/variables.lisp")


;; Compilation des labels

(load "compilateur/cas/labels.lisp")