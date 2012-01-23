(defsystem maxima-json-rpc
  :depends-on (#:restas #:embeddable-maxima
                        #:cl-json)
  :components ((:module "src"
                :components ((:file "defmodule")))))