<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地百科数据表
 */
class Data_Mysql_Table_Spacepedia_Search extends Data_Mysql_Table
{
    public $cols = array(
        'space_name' => '200',
        'nickname' => '200',
        'category_id' => 'int',
        'vendor_id' => 'int',
        'city' => '200',
        'addr' => '200',
        'logo' => '100',
        'mobile_logo' => '100', //移动端banner
        'attr' => 'array',
//        'media' => 'array',
        'des' => 'html',
        'status' => 'tinyint',
//        'subhead'=>'array',
        'level'=>'int',
        'create_time' => 'int',
        'update_time' => 'int',
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'product_id' => 'int',
        'click'=> 'int',
        'order_index'=> 'int',
        'size'=>'int',
        'level'=>'int',
        'price_unit' => '50',
        'min_price' => '100',
        'max_price' => '100',
        'type_level' => 'int',
    );
    public $index = array(
//        'space_name' => 'u',
        'space_name,nickname' => 'title',
//        'nickname' => 'i',
        'attr' => 'attr',
        'price' => 'i',
        'order_index'=>'i',
//        'status' => 'i',
    );
    public $title = array(
        'space_name' => '场地百科名称',
        'nickname' => '别名',
        'category_id' => '分类',
        'vendor_id' => '供应商ID',
        'city' => '城市',
        'addr' => '地址',
        'logo' => 'LOGO',
        'mobile_logo' => '移动端banner',
        'attr' => '属性信息',
        'des' => '场地百科介绍',
        'status' => '状态',//-1 删除    0 下线     1 上线       2 审核中     3 审核拒绝
//        'subhead'=>'副标题',   //活动案例的副标题
        'level'=>'百科等级',    // 0,1,2,3,4      默认为0 A:4 B:3 C:0 D:-1 E:-2
        'create_time' => '创建时间',
        'update_time' => '更新时间',
    );
    public static $category_name=array(
        array('id' => 112, 'name' => '空间', 'parent' => 0),
        array('id' => 113, 'name' => '秀场展馆', 'parent' => 112),
        array('id' => 114, 'name' => '商业广场', 'parent' => 112),
        array('id' => 115, 'name' => '艺术馆画廊', 'parent' => 112),
        array('id' => 116, 'name' => '体育场馆', 'parent' => 112),
        array('id' => 117, 'name' => '影院剧院', 'parent' => 112),
        array('id' => 118, 'name' => '餐厅酒吧', 'parent' => 112),
        array('id' => 119, 'name' => '高端会所', 'parent' => 112),
        array('id' => 120, 'name' => '星级酒店', 'parent' => 112),
        array('id' => 121, 'name' => '会务中心', 'parent' => 112),
        array('id' => 122, 'name' => '公共空间', 'parent' => 112),
        array('id' => 123, 'name' => '社区学校', 'parent' => 112),
        array('id' => 124, 'name' => '特色场地', 'parent' => 112),
        array('id' => 200, 'name' => '文创', 'parent' => 0),
        array('id' => 300, 'name' => '发现', 'parent' => 0),
        array('id' => 400, 'name' => '资讯', 'parent' => 0),
    );

    //获取子分类的父级分类
    static function getChildren($cid){
        $children=array();
        $category=self::$category_name;
        $info=self::getCategoryInfo($category);
        if (empty($info[$cid])) {
            return array();
        }
        //父分类
        if($info[$cid]['parent']==0){
            foreach($category as $k=>$v){
                if($v['parent']==$cid){
                    $children[]=$v['id'];
                }
            }
        }
        return $children;
    }


    static function getCategoryInfo($arr)
    {
        $info = array();
        foreach ($arr as $v) {
            $info[$v['id']] = $v;
        }
        return $info;
    }

}