<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/7/20
 * Time: 16:10
 * 专题页面
 */

$topic=Web_Topic_Info::getInstance();
//更新专题浏览量
$topic->updateCountView();
Web_Topic_Info::display('Web_Feature_Static::topic/topic.tpl');
