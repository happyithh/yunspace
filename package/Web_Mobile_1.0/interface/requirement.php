<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-23
 * Time: 上午11:40
 * 询价
 */
@session_start();
Tpl_Smarty::assign('__seo', array(
    '网页标题'=>'云SPACE|我要办活动',
));
Tpl_Smarty::display( 'Web_Mobile_Static::baike/enquiry.tpl');
