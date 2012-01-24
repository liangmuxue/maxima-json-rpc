#!/bin/sh
curl -i -X POST -d "{\"jsonrpc\": \"2.0\", \"method\": \"evaluate\", \"params\": [\"desolve(['diff(f(x),x,2) = 'diff(g(x),x,1)+sin(x), 'diff(f(x),x,1)-f(x)+x^2 = 2*'diff(g(x),x,2)], [f(x),g(x)]);\"], \"id\": 1}" http://linkfly.ru:8181/jsonrpc
