<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/9/20
 * Time: 16:11
 * 零售ADM详情
 */

Web_Global::openCache(4);
$detail = Web_Retail_Adm_Info::getInstance();
Web_Retail_Adm_Info::display('Web_Static::retail_special/retail_special_detail.tpl');