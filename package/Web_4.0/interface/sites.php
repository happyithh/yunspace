<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/10
 * Time: 14:01
 * 集合页面
 */
$sites = Web_Baike_Classify::getInstance();
Web_Global::openCache(4);
//q($sites->getChildrenName);

Web_Baike_Classify::display( 'Web_Static::classify_1.1/classify.tpl');