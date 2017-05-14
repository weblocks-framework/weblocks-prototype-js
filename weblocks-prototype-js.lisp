;;;; weblocks-prototype-js.lisp

(in-package #:weblocks-prototype-js)


(defmethod get-js-backend-dependencies (app (backend (eql :prototype)))
  (let ((base-path  (weblocks::asdf-system-directory :weblocks-prototype-js)))
    (list 
     (make-instance 'weblocks:script-dependency
                    :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/prototype.js" app)
                    :local-path (merge-pathnames #p"scripts/prototype.js" base-path))
     (make-instance 'weblocks:script-dependency
                    :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/scriptaculous.js" app)
                    :local-path (merge-pathnames #p"scripts/scriptaculous.js" base-path))
     (make-instance 'weblocks:script-dependency
                    :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/weblocks.js" app)
                    :local-path (merge-pathnames #p"scripts/weblocks.js" base-path))
     (make-instance 'weblocks:script-dependency
                    :url (weblocks-utils:prepend-webapp-path "/pub/scripts/prototype-backend/dialog.js" app)
                    :local-path (merge-pathnames #p"scripts/dialog.js" base-path)))))


(defmethod initialize-js-backend ((self weblocks-webapp) (backend (eql :prototype)))
  "Adds handlers to serve scripts from the server."
  (log:debug "Initializing prototype js backend")
  
  (loop for filename in (cl-fad:list-directory
                         (merge-pathnames #p"scripts/"
                                          (weblocks::asdf-system-directory :weblocks-prototype-js)))
        do 
           (let ((uri (format nil "~A/pub/scripts/prototype-backend/~A"
                              (string-right-trim (list #\/) (webapp-prefix self))
                              (file-namestring filename))))
      
             (push (weblocks:create-static-file-dispatcher-and-handler 
                    uri filename)
                   weblocks::*dispatch-table*))))

