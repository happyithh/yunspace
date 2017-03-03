<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/22
 * Time: 17:45
 */
$arr  = Api_Common_SiteMap::createSiteMap();
Tpl_Smarty::assign("data",$arr);
Tpl_Smarty::display('Web_Static', 'v2.0/sitemap.xml');