<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地百科数据表
 */
class Data_Mysql_Table_Spacepedia extends Data_Mysql_Table
{
    public $cols = array(
        'space_name' => '200',
        'nickname' => '200',
        'category_id' => 'int',
        'vendor_id' => 'int',
        'company' => '200', //公司名称
        'province' => '200',   //省份
        'city' => '200',
        'addr' => '200',
        'logo' => '100',
        'mobile_logo' => '100', //移动端banner
        'attr' => 'array',
        'business_circle' => '50',//所属商圈
        'media' => 'array',
        'des' => 'html',
        'status' => 'tinyint',
        'refuse_reason' => '200',
        'subhead'=>'array',
        'brand_history'=>'array',
        'repeat_ids'=>'string',
        'level'=>'int',
        'type_level'=>'int',    //场地级别 下面有定义
        'create_time' => 'int',
        'update_time' => 'int',
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'product_id' => 'int',
        'new_id' =>'int',
        'cache_tags'=>'array',  // 百科下文章关键词缓存
        'other_demo'=>'array',  // 其他信息
        'wenchuang_attr'=>'array',  // 文创属性
    );
    public $index = array(
        'space_name' => 'u',
        'space_name,nickname' => 'title',
//        'nickname' => 'i',
        'attr' => 'attr',
        'repeat_ids' => 'attr',
        'price' => 'i',
        'status' => 'i',
        'level'=>'i',
        'type_level'=>'i',
        'wenchuang_attr'=>'i',
        'city'=>'i'
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
        'media' => '图片信息',
        'attr' => '属性信息',
        'des' => '场地百科介绍',
        'status' => '状态',//-1 删除    0 下线     1 上线       2 审核中     3 审核拒绝
        'refuse_reason' => '拒绝原因',
        'subhead'=>'副标题',   //活动案例的副标题
        'brand_history'=>'品牌故事',   //百科的品牌故事
        'repeat_ids'=>'重复的百科ID',
        'level'=>'百科等级',    // 0,1,2,3,4      默认为0 A:4 B:3 C:0 D:-1 E:-2
        'create_time' => '创建时间',
        'update_time' => '更新时间',
        'wenchuang_attr'=>'文创属性',  // 文创信息
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
        array('id' => 125, 'name' => '写字楼', 'parent' => 112),
        array('id' => 126, 'name' => '游船码头', 'parent' => 112),
        array('id' => 127, 'name' => '文化街区', 'parent' => 112),
        array('id' => 128, 'name' => '产业园区', 'parent' => 112),
        array('id' => 129, 'name' => '试驾场地', 'parent' => 112),
        array('id' => 130, 'name' => '其他', 'parent' => 112),
        array('id' => 200, 'name' => '文创', 'parent' => 0),
        array('id' => 300, 'name' => '发现', 'parent' => 0),
        array('id' => 500, 'name' => '城市', 'parent' => 300),
        array('id' => 400, 'name' => '零售', 'parent' => 0),
    );

    //获取子分类的父级分类
    static function getChildrenByCid($cid)
    {
        $children = array();
        $category = self::$category_name;
        foreach ($category as $k => $val) {
            if ($val['parent']==$cid) {
                $children[$val['id']]=$val['name'];
            }
        }
        return $children;

    }

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
    static function getCategoryName($arr)
    {
        $name = array();
        foreach ($arr as $v) {
            $name[$v['id']] = $v['name'];
        }
        return $name;
    }


    static function getParent($cid){
        $category=self::$category_name;
        $info=self::getCategoryInfo($category);
        if (empty($info[$cid])) {
            return false;
        }
        return $info[$cid]['parent'];
    }
    static function getCategoryId($str){
        $CategoryId='';
        $category=self::$category_name;
            foreach($category as $k=>$v){
                if($str==$v['name']){
                    $CategoryId=$v['id'];
                }
            }
        return $CategoryId;
    }
    static function getCategoryNameById($id){
        $CategoryName='';
        $category=self::$category_name;
        foreach($category as $k=>$v){
            if($id==$v['id']){
                $CategoryName=$v['name'];
            }
        }
        return $CategoryName;
    }
   //百科等级定义
    static $level=array(
        "A"=>'4',
        "B"=>'3',
        "C"=>'0',
        "D"=>'-1',
        "E"=>'-2',
    );
    //分类级别定义
    static $type_level=array(
        "2"=>'核心场地',
        "1"=>'自营场地',
        "0"=>'其他',
    );
    //百科状态定义
    static $status=array(
        1=>'已上线',
        0=>'已下线',
        2=>'审核中',
        3=>'审核拒绝',
        -1=>'已删除',
    );
    //百科描述信息替换
    static $des=array(
        ">"=>"&gt;",
        "<"=>"&lt;",
        '"'=>"&#34;"
    );
    //行业类型
    static $industry_attr=array("通用","医药","IT类","工业类","公益事业","教育","通讯","游戏","动漫","旅游","影视","时尚","文体娱乐", "音乐","政府");

    //活动类型
    static $activity=array(
        "展览展示","文体娱乐","会议会务","新品发布会","行业博览会","演场演出","宴会会议","体验品鉴会","艺术品展出","颁奖晚会/盛典","培训演讲","推广路演","主题展览","主题派对","晚会年会","时尚走秀","动漫游戏","亲子活动","户外拓展",
    );
    //标记重复记号
    static $repeat_str="【有重复】";
}