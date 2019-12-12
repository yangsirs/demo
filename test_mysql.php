<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
$host="127.0.0.1";
$user="root";
$pass="root";
// [ 应用入口文件 ]
$con =  mysqli_connect($host,$user,$pass);
if (!$con)
{
    die('mysqli连接失败: ' . mysqli_connect_error());
}else{
    echo "mysqli链接成功!";
}
die;

?>