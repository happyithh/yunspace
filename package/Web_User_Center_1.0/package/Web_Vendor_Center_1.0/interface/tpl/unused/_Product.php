<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/9
 * Time: 11:55
 */



class Web_Vendor_Center_Product extends Base
{
    static function handle()
    {
        if (empty($_SESSION['user']['super_vendor']) && empty($_SESSION['user']['attr']['identity'])) {
            Func_Header::to('上传产品资料前请先进行实名认证!', 'account');
        }
        unset($_REQUEST['data']['media']['$$']);
        if (!empty($_REQUEST['is_submit']) && !empty($_REQUEST['data']['media'])) {
            $r = Data_Mysql_Vendor_Product_Raw::insert(array(
                'account_id' => $_SESSION['user']['id'],
                'vendor_id' => $_SESSION['user']['attr']['vendor_id'],
                'vendor_name' => empty($_SESSION['user']['attr']['identity']['公司名称']) ? $_SESSION['user']['attr']['identity']['真实姓名'] : $_SESSION['user']['attr']['identity']['公司名称'],
                'raw_data' => array_values($_REQUEST['data']['media']),
                'create_time' => time(),
                'status' => 0,
            ));
            if (empty($r[0])) {
                Func_Header::back('操作失败，请稍候再试或联系客服人员！');
            }
            Func_Header::to('产品资料已成功提交，工作人员会在1个工作日内进行审核并处理！');
        }
        Tpl_Smarty::display('Web_Vendor_Center', 'product_form.tpl');
    }
}
