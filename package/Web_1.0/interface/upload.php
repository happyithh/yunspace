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
if (strpos(Core::$urls['path'], 'ue/') !== false) {
    $oldPath = Core::$paths['root'] . 'upload/' . Core::$urls['action'];
    $newPath = Core::virtualPath('upload/') . Core::$urls['action'];
    Core::mkdir(dirname($newPath));
    copy($oldPath, $newPath);
    header('location: ' . Core::$urls['path'] . '?t=' . time());
    die();
} else if (strpos(Core::$urls['path'], 'image/') !== false) {
    $dirname = Core::virtualPath('upload/');
    $img = file_get_contents('http://w.yunspace.com.cn' . Core::$urls['path']);
    if ($img) {
        Core::mkdir($dirname);
        file_put_contents($dirname . basename(Core::$urls['path']), $img);
        header('location: ' . Core::$urls['path'] . '?t=' . time());
    }
} else {
    $config = Base::getInstance()->___config;
    if (!empty($config['upload_save_path'])) {
        $oldPath = str_replace(array('/', '\\'), DIRECTORY_SEPARATOR, $config['upload_save_path'] . substr(Core::$urls['path'], 8));
        $newPath = Core::virtualPath('upload/') . Core::$urls['action'];
        if (file_exists($oldPath)) {
            if (!file_exists($newPath)) {
                Core::mkdir(dirname($newPath));
                if (filesize($oldPath) < 500 * 1024) {
                    copy($oldPath, $newPath);
                } else {
                    Func_Image::resize($oldPath, 400, 400, $newPath);
                }
            }
            header('location: ' . Core::$urls['path'] . '?t=' . time());
        } elseif (file_exists($newPath)) {
            Core::mkdir(dirname($oldPath));
            $r = rename($newPath, $oldPath);
            if (!$r) {
                $r = copy($newPath, $oldPath);
                if ($r) {
                    if (filesize($oldPath) >= 500 * 1024) {
                        unlink($newPath);
                        Func_Image::resize($oldPath, 400, 400, $newPath);
                    }
                }
            }
            header('location: ' . Core::$urls['path'] . '?t=' . time());
        } else {
            Func_Header::notFound();
        }
    } else {
        Func_Header::notFound();
    }
}