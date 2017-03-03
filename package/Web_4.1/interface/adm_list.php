<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/9/20
 * Time: 15:42
 *
 * 零售ADM数据列表
 */
Web_Global::openCache(4);
Web_Retail_Adm_List::getInstance();
Web_Retail_Adm_List::display('Web_Static::retail_special/retail_special.tpl');
