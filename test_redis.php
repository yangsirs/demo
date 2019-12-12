<?php
//初始化连接
$redis_host = '47.93.123.38';
$redis_port = 16380;
$redis_psw = '^%emwe@46n,swT';
$redis = new Redis ();
$redis->connect ( $redis_host, $redis_port );
$redis->auth ( $redis_psw );
$redis->set('test', 'redis-test');
$get = $redis->get('test');
exit($get);

?>