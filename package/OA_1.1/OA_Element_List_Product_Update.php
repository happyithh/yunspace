<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-9-30
 * Time: 上午9:46
 * product_info_update表中数据
 */
class OA_Element_List_Product_Update
{
    static function handle()
    {
         self::productList();
    }

    /*
     * 产品列表页
     */
    static function productList()
    {
       $res = Api_Element_Product_List::elementProductUpdateList($_REQUEST);
        Tpl_Smarty::assign('_data',$res['data']);
        Tpl_Smarty::display('OA_Static::elements/element_product_update_list.tpl');
    }

}