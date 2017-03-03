<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Vendor_Info extends Data_Mysql_Table
{
    public $cols = array(
        'vendor_name' => '200',
        'categories_id' => '20',
        'vendor_account_id' => 'int',
        'admin_id' => 'int',    //负责人ID
        'city' => '100',    //供应商所在城市
        'addr' => '200',
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'logo' => '100',
        'base_info' => 'array',
        'attr' => 'array',
        'attr_index' => 'array',
        'media_num' => 'int',
        'media' => 'array',
        'des' => 'html',
        'counter_view_index' => 'int',
        'counter_view' => 'int',
        'counter_follow_index' => 'int',
        'counter_follow' => 'int',
        'counter_follow_cancel' => 'int',
        'counter_order' => 'int',
        'counter_order_update' => 'int',
        'counter_order_complete' => 'int',
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',  //-3 拓展丢弃 -2 彻底删除   -1 回收站  0 下线    1 上线    2 待审核   3 审核未通过     4  附属元素审核中
        'vendor_remarks' => 'array',  //其他备注信息     //签约信息   签约状态 0：未签约   2：已签约   1：合作备忘录
        'count_product' => 'int',  //产品总数
        'create_by_quick' => 'int', //1快速创建，0普通创建    2.供应商加盟 3采集供应商
    );
    public $index = array(                                                //p:主键, u:唯一索引, i:索引
        'vendor_name,addr' => 'title',
        'attr_index' => 'attr',
        'categories_id' => 'attr',
        'vendor_account_id' => 'i',
        'geo_lat' => 'i',
        'geo_lng' => 'i',
        'counter_view_index' => 'i',
        'counter_follow_index' => 'i',
        'counter_order' => 'i',
        'status' => 'i',
        'admin_id' => 'i',
        'create_by_quick'=>'i'
    );
    public $title = array(
        "" => "供应商信息",                                                     //空键,表名
        'vendor_name' => ' 供应商名称',
        'addr' => '地址',
        'categories_id' => '服务范围ID',
        'contacts' => '联系人',
        'geo_lat' => '地理GEO-LAT',
        'geo_lng' => ' 地理GEO-LNG',
        'attr' => '属性数据',
        'attr_index' => '属性索引-扁平',
        'media' => '媒体材料',
        'media_num' => '媒体材料',
        'des' => '介绍',
        'counter_view_index' => '浏览量',
        'counter_view' => '浏览量',
        'counter_follow_index' => '订阅量',
        'counter_follow' => '订阅量',
        'counter_follow_cancel' => '取消订阅量',
        'counter_order' => '订单数',
        'counter_order_update' => '订单数',
        'counter_order_complete' => '完成订单数',
        'create_time' => '添加时间',
        'update_time' => '更新时间',
        'admin_id' => '关联审核人员',
        'count_product' => '产品总数',
    );
    public $titleHidden = array( //    list / form / both
        'geo_lat' => 'both',
        'geo_lng' => 'both',
        'categories_id' => 'both',
        'attr_index' => 'both',
        'media' => 'list',
        'media_num' => 'form',
        'contacts' => 'both',
        'des' => 'list',
        'attr' => 'list',
        'addr' => 'list',
        'counter_view_index' => 'both',
        'counter_follow_index' => 'both',
        'counter_order' => 'both',
        'create_time' => 'list',
        'update_time' => 'list',
    );
    public $filter = array(
        'status' => array(
            99 => '回收站',
            98 => '停用',
            1 => '正常',
            0 => '待审核',
        ),
    );

    static function attrToIndex($attr)
    {
        unset($attr['基本信息>停车位'], $attr['基本信息>人数上限'], $attr['基本信息>面积'], $attr['基本信息>层高'], $attr['基本信息>供电量']);
        return $attr;
    }

    static function initCountProduct($vendorId)
    {
        if (empty($vendorId)) {
            Func_Header::back('参数错误！！');
        }
        $product = Data_Mysql_Table_Product_Info::subTable("_update")->select('count(*) as c', array('vendor_id' => $vendorId));
        if (isset($product[0])) {
            Data_Mysql_Table_Vendor_Info::query("UPDATE {table} SET count_product = ? WHERE id = ?", array($product[0]['c'], $vendorId), 1);
            Data_Mysql_Table_Vendor_Info::query("UPDATE {table}_update SET count_product = ? WHERE id = ?", array($product[0]['c'], $vendorId), 1);
        }
    }
}