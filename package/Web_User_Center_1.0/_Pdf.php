<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-4-1
 * Time: 下午4:31
 * 产品信息打印PDF
 */
class Web_User_Center_Pdf extends Base
{
    static function handleProductPdf($productId)
    {
        if(empty($productId)){
            Func_Header::back('缺少参数');
        }
        $cols = array('{table}.id','{table}.addr', '{table}.product_name', '{table}.product_size', '{table}.media', '{table}.category_id', '{table}.attr', '{table}.des', '{prefix}vendor_info.vendor_name');
        //读取产品信息
        $rs = Data_Mysql_Table_Product_Info::select($cols, array('id' => $productId), '', 1, '{table} LEFT JOIN {prefix}vendor_info on {table}.vendor_id = {prefix}vendor_info.id');
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        $productInfo = $rs[0];
        $productInfo['attr'] = json_decode($productInfo['attr'], 1);
        //处理图片数组
        if (!empty($productInfo['media'])) {
            $productInfo['media'] = json_decode($productInfo['media'], 1);
        }
        //读取分类信息
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        $productInfo['category_name'] = $categories[$productInfo['category_id']][0];

        Tpl_Smarty::assign('data', $productInfo);
        //案例
        $productCase = Data_Mysql_Table_Event_Case::select('*', array('product_id = ?' => $productId, 'status = ?' => 1), '', '3');
        foreach ($productCase as $key => $val) {
            $productCase[$key]['media'] = json_decode($val['media'], 1);
        }
        Tpl_Smarty::assign('caseData', $productCase);
        $product_tmp = Tpl_Smarty::fetch('Web_User_Center', 'inc/product_templete.tpl');
        $logo = Core::$paths['root'] . 'package/Web_User_Center_1.0/interface/assets/' . 'images/logo.png';

        Func_Pdf::html2pdf('', $product_tmp, $logo);
    }

    /**
     *
     *生成套餐的pdf
     *
     */
    static function handleProductSetPdf()
    {
        $request = Func_Input::filter(array(
            'set_id' => 'int'
        ));

        if (empty($request['set_id'])) {
            Func_Header::notFound();
        }
        $page = Web_Product_Set_Info::getInstance();
        $page->id = $request['set_id'];
        $product_tmp = Web_Product_Set_Info::fetch('Web_User_Center::inc/product_set_templete.tpl');
//        q(Core::getAssetsUrls('Web_User_Center_1.0') . 'images/logo.png');
        $logo = Core::$paths['root'] . Core::getAssetsUrls('Web_User_Center_1.0') . 'images/logo.png';
        Func_Pdf::html2pdf('', $product_tmp, $logo);
    }
}
