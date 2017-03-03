<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/28
 * Time: 10:20
 */
/**
 * 处理缩略图和水印
 */

header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");
if (!empty($_REQUEST['t'])) {
    die();
}
$path = explode('/', Core::$urls['action'], 2);
if (empty($path[1])) {
    Func_Header::noPic();
}
////START 处理来源路径, 如果不在save_path  则  移动,   最终使用 save_path
$config = Base::getInstance()->___config;
if (!empty($config['upload_save_path'])) {
    $srcPath = str_replace(array('/', '\\'), DIRECTORY_SEPARATOR, $config['upload_save_path'] . $path[1]);
    $oldPath = Core::virtualPath('upload/') . $path[1];
    if (!file_exists($srcPath) && file_exists($oldPath)) {
        Core::mkdir(dirname($srcPath));
        $r = rename($oldPath, $srcPath);
        if (!$r) {
            $r = copy($oldPath, $srcPath);
            if ($r) {
                unlink($oldPath);
            }
        }
    } elseif (!file_exists($srcPath)) {
        $www_src=Page_Site_Global::uploadHost().Core::$urls['path'];
        header('location: ' . $www_src);
        exit();
//        if (Core::$urls['host'] != 'www.yunspace.com.cn' && Core::$urls['host'] != 'yunspace.com.cn') {
//            Func_Header::location('http://www.yunspace.com.cn' . Core::$urls['path']);
//        }
//        Func_Header::noPic();
    }
} else {
    $srcPath = str_replace(array('/', '\\'), DIRECTORY_SEPARATOR, $config['upload_path'] . $path[1]);
}

////END 处理来源路径, 如果不在save_path  则  移动,   最终使用 save_path
$srcPath = str_replace(array('/', '\\'), DIRECTORY_SEPARATOR, $config['upload_save_path'] . $path[1]);
$newImgPath = Core::virtualPath('uploads/') . Core::$urls['action'];
//if (!file_exists($srcPath)) {
//    $srcPath = Core::virtualPath('upload/') . $path[1];
//}
if (!file_exists($srcPath)) {
    //跳转到yun.bb或者是master.yunspace.com.cn  w为空代表首次请求场地大师
    if(empty($_REQUEST['w'])){
        $www_src=Page_Site_Global::uploadHost().Core::$urls['path'];
        header('location: ' . $www_src."?m=".time());
        exit();
    }
   if (Core::$urls['host'] != 'www.yunspace.com.cn' && Core::$urls['host'] != 'yunspace.com.cn') {
       Func_Header::location('http://www.yunspace.com.cn' . Core::$urls['path']);
   }
   Func_Header::noPic();
}
if ($path[0] == 'yunspace_src') {
    Core::mkdir(dirname($newImgPath));
    Func_Image::thumCenterImage($srcPath, $newImgPath, 1600, 0);
    header('location: ' . Core::$urls['path'] . '?t=' . time());
    die();
}
$r = explode('_', $path[0] . '____');
$config = array(
    'width' => $r[0],
    'height' => $r[1],
    'stamp' => $r[2],
);
if($r[3]=='thc'){
    $image_size   =   getimagesize($srcPath);
    Func_Image::thumbImage($srcPath, $srcPath, 0, 0, $image_size[0]*0.87, $image_size[1]*0.87,$image_size[0]*0.87);
}
if (!is_numeric($config['width']) || !$config['width']) {
    Func_Header::noPic();
}
Core::mkdir(dirname($newImgPath));
if ($config['height']) {
    Func_Image::thumCenterImage($srcPath, $newImgPath, $config['width'], $config['height']);
} else {
    Func_Image::resize($srcPath, $config['width'], $config['height'], $newImgPath);
}
if ($config['stamp']) {
    //打水印
    Func_Image::imageWaterMark($newImgPath, 9, dirname(__FILE__) . ($config['width'] >= 600 ? '/assets/images/shuiyin_new2.png' : '/assets/images/shuiyin-min_new2.png'));
    if ($config['stamp'] == 2) {
        Func_Image::imageWaterMark($newImgPath, 5, dirname(__FILE__) . '/assets/images/shuiyin-2.png');
    }
}
//readfile($newImgPath);
//Func_Header::location(Core::$urls['path']);

header('location: ' . Core::$urls['path'] . '?t=' . time());