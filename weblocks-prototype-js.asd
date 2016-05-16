;;;; weblocks-prototype-js.asd

(asdf:defsystem #:weblocks-prototype-js
  :serial t
  :description "Describe weblocks-prototype-js here"
  :author "Olexiy Zamkoviy <olexiy.z@gmail.com>"
  :license "LLGPL"
  :depends-on (#:weblocks)
  :components ((:file "package")
               (:file "weblocks-prototype-js")))

