;;;; weblocks-prototype-js.asd

(asdf:defsystem #:weblocks-prototype-js
  :serial t
  :description "Weblocks JavaScript backend for PrototypeJs"
  :author "Olexiy Zamkoviy <olexiy.z@gmail.com>"
  :license "LLGPL"
  :version "0.0.1"
  :depends-on (#:weblocks)
  :components ((:file "package")
               (:file "weblocks-prototype-js")))

