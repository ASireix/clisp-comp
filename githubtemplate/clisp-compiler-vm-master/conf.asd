(defsystem :clisp-compiler-vm
  :description "A Lisp compiler and VM"
  :version "1.0"
  :components ((:module "machine"
                :components
                ((:file "machine")))
               (:file "main")))
