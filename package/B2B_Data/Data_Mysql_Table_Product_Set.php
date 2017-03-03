<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/12
 * Time: 9:52
 */
Class  Data_Mysql_Table_Product_Set extends Data_Mysql_Table
{

    public $cols = array(
        'set_name' => '200',               //  套餐名称
        'version' => '20',                       //  版本
        'addr' => '200',                       //  地址
        'des' => 'html',                       //产品介绍
        'category_id' => 'int',                  //分类id
        'vendor_id' => 'int',                  //供应商id
        'vendor_name' => '100',                    //  供应商名称
        'hours' => 'int',                    //  小时数
        'people' => 'int',                    //  人数
        'schedule_product_id' => 'int',              //关联档期产品ID
        'attr_index' => 'array',                   //标签
        'logo' => '100',                     //logo
        'media' => 'array',                   //图片资源
        'detail_data' => 'array',            //套餐版本细节
        'detail' => 'array',            //套餐版本细节2
        'detail_des' => 'html',            //套餐版本细节2
        'counter_order' => 'int',              //订单总数
        'create_time' => 'int',             //创建时间
        'update_time' => 'int',          //修改时间
        'score' => 'int',                //评分
        'counter_view' => 'int',                //浏览量
        'counter_view_index' => 'int',                //浏览量的索引
        'set_price' => 'int',                //价格
        'status' => 'tinyint',               //0下线，1上线，2待审核，3审核未通过  -n  关闭
        'refuse_reason' => '100',                //被拒绝的理由
        'counter_follow' => 'int',//收藏量
        'marketing_title' => '200'          //套餐营销标题

    );

    public $index = array(
        'set_name,addr,vendor_name' => 'title',
        'category_id' => 'i',
        'hours' => 'i',
        'people' => 'i',
        'set_price' => 'i',
        'counter_view_index' => 'i',
        'attr_index' => 'attr',
        'detail' => 'attr',
    );

    public $title = array();

    public static $category_name = array(
        6 => '会议沙龙',
        3 => '路演',
        2 => '发布会',
        1 => '派对酒会',
        4 => '年会',
//        5 => '派对',
//        7 => '沙龙',
        8 => '亲子',
        9 => '团建',
        10 => '聚会',
        11 => '优质配套服务',
        12 => '试乘试驾',
        13 => '婚宴',
        14 => '宴会',
    );
    public static $versions = array(
        '品质版',
        '奢华版',
    );

    public static $orderBy = array(
        1 => '综合排序',
        2 => '最热排序',
        3 => '最新排序',
    );

    static function handleDelete($set_id, $status = -1)
    {
        //更新产品状态
        $r = Data_Mysql_Table_Product_Set::query("UPDATE {table} SET status = ? WHERE id = ?", array($status, $set_id), 1);
        $r_update = Data_Mysql_Table_Product_Set::query("UPDATE {table}_update SET status = ? WHERE id = ?", array($status, $set_id), 1);
        if (empty($r[0]) || empty($r_update[0])) {
            return false;
        }
        return true;
    }

    static function footPrint($id)
    {
        self::query("UPDATE {table} SET  counter_view=counter_view+1 WHERE id =?", array($id), 1);
    }
}
