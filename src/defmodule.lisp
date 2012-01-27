(restas:define-module :maxima-json-rpc
  (:use #:cl #:restas #:json #:json-rpc))

(in-package :maxima-json-rpc)



(defun ensure-valid-maxima-input (input)
  "Returns string with appended ';', if input string does not have maxima command terminator at the end."
  (let* ((input-trimmed (string-trim '(#\Space #\Newline #\Tab) input))
        (last-char (char input-trimmed (1- (length input-trimmed)))))
    (if (and (not (char= #\; last-char)) (not (char= #\$ last-char)))
        (concatenate 'string input-trimmed ";")
        input-trimmed)))

(defun maxima-ast-from-string (input)
  (maxima::macsyma-read-string (ensure-valid-maxima-input input)))

(defmacro with-2d-output (&body body)
  `(let ((maxima::$display2d nil))
     ,@body))

(defun-json-rpc evaluate :explicit (text)
  "Evaluate maxima expression"
  (let ((result (make-array '(0) :element-type 'base-char :fill-pointer 0 :adjustable t)))
    (with-output-to-string (*standard-output* result)
      (with-2d-output
        (maxima::displa
         (maxima::mfuncall 'maxima::$ev (maxima-ast-from-string text)))))
    result))

(define-route jsonrpc ("jsonrpc"
                            :method :post 
                            ;;:content-type "application/json"
                            )
  "json rpc route"
  (let ((*json-rpc-version* +json-rpc-2.0+))
    (invoke-rpc (hunchentoot:raw-post-data :force-text t))))

(define-route example ("example")
   (merge-pathnames "examples/js-maxima-rpc-client.html" (asdf:component-pathname (asdf:find-system :maxima-json-rpc))))

