<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Config_Vendor_Attr extends Data_Config
{

    public $all = array(
        "base_info" => array(
            "公司名称" => '',
            "公司地址" => '',
            "公司电话" => '',
            "公司传真" => '',
            "法人代表" => '',
            "法人代表身份证号码" => '',
            "主要联系人" => '',
            "联系方式" => '',
            "公司网址" => '',
            "注册地址" => '',
            "注册资本" => '',
            "营业执照编号" => '',
            "税务登记号" => '',
            "员工总数" => '',
            "管理人员" => '',
            "开户银行" => '',
            "银行账号" => '',
            "供货以及服务范围" => '',
        ),
        'attr' => '',

    );

    static function vendorAttr()
    {

        $tagsAll = Data_Mysql_Table_Tags::getInfoCache();
        $attr = array(
            "城市" => $tagsAll[46]['tags_value'],
            "服务行业" => $tagsAll[9]['tags_value'],
            "活动类型" => $tagsAll[49]['tags_value'],
            "公司规模" => array('50以下', '50-100', '100-500', '500以上'),
            "资质认证" => array('三证齐全', '大型供应商', '资深供应商', '知名品牌', '快速响应', '五星好评'),
        );
        self::all();
        self::getInstance()->all['attr'] = $attr;
//        Data_Config_Vendor_Attr::set('attr',$attr);
    }
}

Data_Config_Vendor_Attr::vendorAttr();