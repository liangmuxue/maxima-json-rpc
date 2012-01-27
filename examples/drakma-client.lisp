(ql:quickload :drakma)
(ql:quickload :cl-json)

(drakma:http-request "http://linkfly.ru:8181/jsonrpc"
                     :method :post
                     :content-type "application/json"
                     :content
                     (json:encode-json-alist-to-string
                      '((:id . 1)
                        (jsonrpc . "2.0")
                        (method . "evaluate")
                        (params . ("1 + 2")) ())))