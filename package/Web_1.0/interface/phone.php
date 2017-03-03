<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/7
 * @手机页面
 */
switch(Core::$urls['action']){
    case 'intro':
        Web_Phone_Page::phone_intro();
        break;
    case 'demand_submit':
        Web_Phone_Page::phone_demand();
        break;
    default:
        Func_Header::notFound();
}
class  Web_Phone_Page{
    /*
     * 简介
     * */
    static  function phone_intro(){

        Tpl_Smarty::display('Web','phone_intro.tpl');
    }

    /*
     *  发布需求
     * */
    static function  phone_demand(){


        Tpl_Smarty::assign('vendor_attr', Web_HomePage::vendorAttr());
        Tpl_Smarty::display('Web','phone_demand_submit.tpl');
    }


}
