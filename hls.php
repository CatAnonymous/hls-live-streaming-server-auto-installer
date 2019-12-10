<?php
// Coded by Khai Phan

header("Content-Type: text/plain");

$accounts = array(

  'admin' => '123456',

);

$username = $_GET['user'] ?? '';
$password = $_GET['pass'] ?? '';

if ($username == '' || $password == '' || !array_key_exists($username, $accounts) || $password != $accounts[$username]) {
  http_response_code(403);
  exit;
}

$uri = $_GET['uri'] ?? '';
$path = '/tmp/hls/';
$file = $path . $uri;

if ($uri == '' || !is_file($file)) {
  http_response_code(404);
  exit;
} else {
  $ext = pathinfo($file, PATHINFO_EXTENSION);
  if ($ext == 'm3u8') {
    $mime = 'application/vnd.apple.mpegurl';
  } elseif ($ext == 'ts') {
    $mime = 'video/mp2t';
  } else {
    $mime = 'application/octet-stream';
  }
  
  header("Cache-Control: no-cache");
  header("Access-Control-Allow-Origin: *");
  header("Access-Control-Expose-Headers: Content-Length,Content-Range");
  header("Access-Control-Allow-Headers: Range");
  header("Content-Type: " . $mime);
  
  if ($ext == 'm3u8') {
    $out = file_get_contents($file);
    $out = preg_replace('/(.*\.ts)/', "$1?user=$username&pass=$password", $out);
    echo $out;
  } else {
    readfile($file);
  }
}
