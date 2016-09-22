;;;; weblocks-prototype-js.lisp

(in-package #:weblocks-prototype-js)

(defmethod weblocks-webapp-dependencies-for-backend ((self weblocks-webapp) (backend (eql :prototype)))
  (let ((base-path  (weblocks::asdf-system-directory :weblocks-prototype-js)))
    (list 
      (make-instance 'weblocks:script-dependency :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/prototype.js" self)     :local-path (merge-pathnames #p"scripts/prototype.js" base-path))
      (make-instance 'weblocks:script-dependency :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/scriptaculous.js" self) :local-path (merge-pathnames #p"scripts/scriptaculous.js" base-path))
      (make-instance 'weblocks:script-dependency :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/weblocks.js" self)      :local-path (merge-pathnames #p"scripts/weblocks.js" base-path))
      (make-instance 'weblocks:script-dependency :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/dialog.js" self)        :local-path (merge-pathnames #p"scripts/dialog.js" base-path)))))

(defmethod weblocks-webapp-init-dependencies-for-backend ((self weblocks-webapp) (backend (eql :prototype)))
  (loop for i in (cl-fad:list-directory (merge-pathnames #p"scripts/" (weblocks::asdf-system-directory :weblocks-prototype-js))) do 
        (push (weblocks:create-static-file-dispatcher-and-handler 
                (format nil "~A/pub/scripts/prototype-backend/~A" (string-right-trim (list #\/) (webapp-prefix self)) (file-namestring i)) i)
              weblocks::*dispatch-table*)))

(defmethod weblocks-webapp-default-dependencies :around ((self weblocks-webapp))
  (append 
    (when (equal (weblocks:weblocks-webapp-js-backend self) :prototype)
      (weblocks-webapp-dependencies-for-backend self :prototype))
    (call-next-method)))

(defmethod initialize-webapp :after ((self weblocks-webapp))
  ; Serving all files from scripts/ directory
  (when (equal (weblocks-webapp-js-backend self) :prototype)
    (weblocks-webapp-init-dependencies-for-backend self :prototype)))
