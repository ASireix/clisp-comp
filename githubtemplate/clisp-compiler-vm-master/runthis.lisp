(defun load-and-provide-all-files (directory)
  "Load all .lisp files in DIRECTORY and its subdirectories, then provide them."
  (let ((absolute-path (truename directory)))
    (when (probe-file absolute-path)
      (dolist (file (directory (merge-pathnames "**/*.lisp" absolute-path)))
        (load file)
        (provide (pathname-name file))))))
(load-and-provide-all-files "E:/Cours/Master GL 2024/Cours M1/Compilation/clisp-compiler-vm-master/")
