<?php

/**
 * Created by PhpStorm.
 * User: ycl
 * Date: 2015/6/15
 * Time: 9:52
 */
Class  Data_Mysql_Table_Raiders_Info extends Data_Mysql_Table
{
    public $cols = array(
        'title' => '200',                      //攻略标题
        'des' => 'html',                       //攻略简介
        'category_id' => 'int',                //分类id
        'cont' => 'html',                      //主题内容
        'logo' => '100',                       //logo
        'author' => '20',                      //作者
        'create_time' => 'int',                //创建时间
        'update_time' => 'int',                //更新时间
        'media' => 'array',
        'counter_view' => 'int',                //浏览量
        'counter_praise' => 'int',               //好赞量
        'counter_tread' => 'int',               //踩量
        'city' => '20',                             //城市
        'status' => 'tinyint',                 //0下线，1上线    （update表  -1 丢弃）
        'tags_info' => 'array',                   //关键词
        'label_info' => 'array',                   //文章标签 ，不知道咋用，先加上
        'baike_word' => 'array',                   //百科名称   （无用）
        'accessory' => 'array',      //文件地址
        'download' => 'int',      //下载量
        'from_where' => 'int',                  //文章来源标识,1为手动录入，2为自动采集，3为投稿 （update表 100 代表案例）
        'detail_des' => 'array',           //添加附加信息，如地址，信息，开馆时间等
        'hide_logo' => 'int',        //是否在详情页显示logo
        'is_hot' => 'tinyint',          //是否为置顶文章，1为是，0为否
        'is_good' => 'tinyint',          //设置为推荐文章，1为是，0为否
        'account_id' => 'int',          //注册用户投稿的ID
        'update_id' => 'int',          //update表中的id
        'baike_category_id' => '200',   //文章在关联的百科中的分类  （无用）
        'baike_cid' => '200',   //文章在关联的百科中的分类  (新)
        'from_url' => '100',          //文章的来源，出处网址
        'space_ids' => '100',      //  关联百科的id
        'actor' => '50',      //  演员名
        'img_set' => '300',      //图片集合       用于列表
        'is_jump'=>'100',   //跳转网址
        'original_link'=>'100',   //原文链接

    );
    public $index = array(
        'title,author' => 'title',
        'tags_info' => 'attr',
//        'baike_word' => 'attr',
        'label_info' => 'attr',
        'space_ids' => 'attr',
        'baike_cid' => 'attr',
        'des' => 'des',
        'account_id' => 'i',
        'create,counter_praise' => 'i',
        'actor' => 'i',
        'img_set' => 'i',
        'create_time' => 'i',
    );


    public static $category_name = array(
        array('id' => 1, 'name' => '资讯', 'parent' => 0),
        array('id' => 16, 'name' => '活动', 'parent' => 1),
        array('id' => 17, 'name' => '空间', 'parent' => 1),
        array('id' => 18, 'name' => '创意', 'parent' => 1),
//        array('id' => 21, 'name' => '嗨·空间', 'parent' => 1),  //=>18
        array('id' => 19, 'name' => '榜单', 'parent' => 1),
        array('id' => 3, 'name' => '行业', 'parent' => 1),
        array('id' => 30, 'name' => '推广', 'parent' => 1),
        array('id' => 23, 'name' => '攻略', 'parent' => 0),
        array('id' => 6, 'name' => '案例', 'parent' => 0),
//        array('id' => 23, 'name' => '活动攻略', 'parent' => 0),
        array('id' => 20, 'name' => '发布会/路演/展览', 'parent' => 6),
        array('id' => 21, 'name' => '典礼/晚会/年会', 'parent' => 6),
        array('id' => 5, 'name' => '派对/沙龙', 'parent' => 6),
        array('id' => 24, 'name' => '会议/讲座', 'parent' => 6),
//        array('id' => 23, 'name' => '活动攻略', 'parent' => 0),
        array('id' => 2, 'name' => '策划', 'parent' => 23),
        array('id' => 11, 'name' => '营销', 'parent' => 23),
        array('id' => 10, 'name' => '执行', 'parent' => 23),
//        array('id' => 4, 'name' => '经典创意', 'parent' => 1),// =>18
//        array('id' => 9, 'name' => '活动资讯', 'parent' => 0), //=>16
//        array('id' => 7, 'name' => '经验分享', 'parent' => 0), //=>11
//        array('id' => 8, 'name' => '精心推荐', 'parent' => 0), //=>17
        array('id' => 12, 'name' => '文库', 'parent' => 0),
        array('id' => 13, 'name' => '活动方案', 'parent' => 12),
        array('id' => 14, 'name' => '策划技巧', 'parent' => 12),
        array('id' => 22, 'name' => '演讲稿', 'parent' => 12),
        array('id' => 15, 'name' => '营销传播', 'parent' => 12),
//        array('id' => 27, 'name' => '文创', 'parent' => 0),     //2016年6-7日  赵志超注释
//        array('id' => 28, 'name' => '角色', 'parent' => 27),
//        array('id' => 29, 'name' => '故事', 'parent' => 27),
//        array('id' => 25, 'name' => '活动百科', 'parent' => 0),
//        array('id' => 26, 'name' => '大千世界', 'parent' => 25),
    );


//栏目改版，此处暂时丢弃
//    public static $category_namea = array(
//        array('id' => 8, 'name' => '精心推荐', 'parent' => 0),
//        array('id' => 16, 'name' => '云·活动', 'parent' => 8),
//        array('id' => 17, 'name' => '云·空间', 'parent' => 8),
//        array('id' => 18, 'name' => '云·艺术', 'parent' => 8),
//        array('id' => 19, 'name' => '云·榜单', 'parent' => 8),
//        array('id' => 20, 'name' => '云·案例', 'parent' => 8),
//        array('id' => 21, 'name' => '嗨·空间', 'parent' => 8),
//        array('id' => 1, 'name' => '活动方案', 'parent' => 0),
//        array('id' => 6, 'name' => '活动案例', 'parent' => 0),
//        array('id' => 7, 'name' => '经验分享', 'parent' => 0),
//        array('id' => 12, 'name' => '活动文库', 'parent' => 0),
//        array('id' => 2, 'name' => '年会攻略', 'parent' => 1),
//        array('id' => 3, 'name' => '行业动态', 'parent' => 1),
//        array('id' => 4, 'name' => '经典创意', 'parent' => 1),
//        array('id' => 5, 'name' => '文化沙龙', 'parent' => 1),
//        array('id' => 9, 'name' => '活动资讯', 'parent' => 0),
//        array('id' => 10, 'name' => '活动策划/执行', 'parent' => 9),
//        array('id' => 11, 'name' => '营销传播', 'parent' => 9),
//        array('id' => 13, 'name' => '活动方案', 'parent' => 12),
//        array('id' => 14, 'name' => '演讲稿', 'parent' => 12),
//        array('id' => 15, 'name' => '策划技巧', 'parent' => 12),
//Page_Site_Global::displayMedia();
//    );

    public static $status = array(
        1 => '上线',
        -1 => '下线',
    );

    //根据一个category_Id查到对应的父catrgory_id和子category_id
    public static function categoryRelation($cid)
    {
        $allCategory = self::$category_name;
        $topCategory_id = array();
        $topCategory_id['top_id'] = $cid;
        $topCategory_id['sub_id'] = 0;
        foreach ($allCategory as $val) {
            if ($val['id'] == $cid) {
                if ($val['parent'] != 0) {
                    $topCategory_id['top_id'] = $val['parent'];
                    $topCategory_id['sub_id'] = $cid;
                    break;
                }
            }
        }
        if (!empty($topCategory_id)) {
            return $topCategory_id;
        }
        return false;
    }


    //获取该id下的所有子栏目id（包括父id）
    static function getCategoryChildren($cid)
    {
        $allCategory = self::$category_name;
        $children = array($cid);

        foreach ($allCategory as $val) {
            if ($val['parent'] == $cid) {
                $children[] = $val['id'];
                continue;
            }
        }
        return $children;
    }

    //获取该id下的所有子栏目name）
    static function getCategoryChildrenName($cid)
    {
        $allCategory = self::$category_name;

        $children = array();

        foreach ($allCategory as $val) {
            if ($val['parent'] == $cid) {
                $children[$val['id']] = $val['name'];
            }
        }
        return $children;
    }

    static function getCategoryClass()
    {
        $allCategory = self::$category_name;
        $data = array();
        $child = array();
        foreach ($allCategory as $val) {
            if ($val['parent'] == 0) {
                $child[$val['id']] = $val['name'];
            }
            foreach ($allCategory as $vv) {
                if ($val['id'] == $vv['parent']) {
                    $child[$vv['id']] = $vv['name'];
                }
            }
            if ($val['parent'] == 0) {
                $data[$val['name']] = $child;
                $child = array();
            }
        }
        return $data;
    }

    //刷新一个网页则浏览量+1
    static function footPrint($id)
    {
        self::query("UPDATE {table} SET  counter_view=counter_view+1 WHERE id =?", array($id), 1);
    }

    /**
     * @param $args
     * @return mixed
     * 大于 3 个
     * 获取 文章内的  img src
     */
    static function  getImgSrc($args)
    {
        if (empty($args)) {
            return false;
        }
        $preg = '/<img.*?src=[\"|\']?(.*?)[\"|\']?\s.*?>/i';
        preg_match_all($preg, $args, $imgArr);
        if (!empty($imgArr[1][2])) {
            return $imgArr[1];
        }
        return false;
    }

    /**
     * @param $args
     * @return array|bool
     * 处理表单提交过来的 img_set  数据
     */
    static function handleImgSet($args)
    {
        if (empty($args)) {
            return false;
        }
        $data = explode(',', $args);
        if (empty($data[2])) {
            return false;
        }
        $img_set = array();
        foreach ($data as $val) {
            $arr = explode('static/', $val);
            if (!empty($arr[1])) {
                $img_set[] = '/static/' . $arr[1];
            }
        }
        if (count($img_set) < 3) {
            return false;
        }

        return implode(',', $img_set);
    }

}
