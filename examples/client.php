// Uses JSON-RPC PHP http://jsonrpcphp.org

<?php
  require_once 'jsonRPCClient.php';
  $maxima = new jsonRPCClient('http://127.0.0.1:9090/jsonrpc');
  print "Maxima evaluator\n";
  print "Evaluate ratsimp(x^2 + 2*x + 1 - (x + 1)^2)\n";
  print $maxima->evaluate("ratsimp(x^2 + 2*x + 1 - (x + 1)^2)");

  print "Evaluate x^2 + 2*x + 1 + (x + 1)^2 in environment x=2\n";
  print $maxima->evaluate("ev(x^2 + 2*x + 1 + (x + 1)^2, x=2)");
?>

