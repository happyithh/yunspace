<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Product_Category extends Data_Mysql_Table
{
    public $cols = array(
        'parent_id' => 'int',
        'category_name' => '50',
        'attr_info' => 'array',
        'attr_cache' => 'array',
        'sort_weight' => 'tinyint',
        'status' => 'tinyint',
        'tags_info' => 'array',
    );
    public $index = array(
        'parent_id,category_name' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'sort_weight' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "产品分类",                                                     //空键,表名
        'parent_id' => '上级ID',
        'category_name' => '分类名',
        'sort_weight' => '排序优先级',
        'attr_info' => '属性预定义',
        'tags_info' => '标签预定义',
    );
    public $titleHidden = array( //    list / form / both
        'attr_info' => 'list',
    );
    public $filter = array(
        'status' => array(
            99 => '回收站',
            98 => '停用',
            1 => '正常',
        ),
    );

    static function getInfoCache()
    {
        $data = Core::readData(Core::$paths['temp'] . get_called_class() . '.info');
        if (!$data) {
            $rs = self::updateCache();
            $data = $rs['info'];
            $data['-1'] = true;
        }
        return $data;
    }

    static function getTreeCache()
    {
        $data = Core::readData(Core::$paths['temp'] . get_called_class() . '.tree');
        if (!$data) {
            $rs = self::updateCache();
            $data = $rs['tree'];
            $data['-1'] = true;
        }
//        foreach ($data[0] as $key => $value) {
//            if (empty($value)) {
//                unset($data[0][$key]);
//            }
//        }
        return $data;
    }

    static function updateCache()
    {
        $data = array('info' => array(), 'tree' => array());
        $rs = Data_Mysql_Table_Product_Category::select('*', '', 'ORDER BY parent_id ASC, sort_weight DESC', 500);
        if (!empty($rs)) {
            foreach ($rs as $r) {
                $data['info'][$r['id']] = array($r['category_name'], json_decode($r['attr_info'], 1), $r['status'], $r['parent_id']);
                $data['info'][$r['id']]['tags_info'] = json_decode($r['tags_info'], 1);
                $data['tree'][$r['parent_id']][$r['id']] = $r['status'] == 1 ? $r['category_name'] : '';
            }
            Core::writeData(Core::$paths['temp'] . get_called_class() . '.tree', $data['tree'], 99999999);
            Core::writeData(Core::$paths['temp'] . get_called_class() . '.info', $data['info'], 99999999);
        }
        return $data;
    }

    static function clearCache()
    {
        Core::writeData(Core::$paths['temp'] . get_called_class() . '.tree', '', 99999999);
        Core::writeData(Core::$paths['temp'] . get_called_class() . '.info', '', 99999999);
        self::exec('UPDATE {table} SET attr_cache = "" WHERE 1');
    }

    static function getChildren($cid)
    {
        $tree = self::getTreeCache();
        if (empty($tree[$cid])) {
            return array();
        }
        $children = array_keys($tree[$cid]);
        foreach ($children as $k => $v) {
            $children += self::getChildren($v);
        }
        return $children;
    }

    static function getCategoryAttr($cid)
    {
        $attr = array();
        $info = Data_Mysql_Table_Product_Category::getInfoCache();
        while (!empty($info[$cid])) {
            if (!empty($info[$cid][1])) {
                $attr = array_merge($info[$cid][1], $attr);
            }
            $cid = $info[$cid][3];
        }
        return array_merge(array(
            array(
                'name' => '城市',
                'values' => empty($_REQUEST['cities']) ? '上海,北京,广州,深圳,成都,杭州' : implode(',', $_REQUEST['cities'])
            ),
            array(
                'name' => '市场价',
                'values' => ''
            ),
            array(
                'name' => '价格单位',
                'values' => '元/天'
            ),
            array(
                'name' => '基本信息>适合活动类型',
                'values' => '商业发布,展览展示,文体娱乐,会议会务,新品发布会,行业博览会,演场演出,会议论坛,体验品鉴会,艺术品展出,颁奖晚会/盛典,培训演讲,推广路演,主题展览,主题派对,晚会年会,时尚走秀,动漫游戏,亲子活动,户外拓展'
            )
        ), $attr);
    }

    //search  1可搜索 0不可搜索 ；  hide 1隐藏 0显示
    static function getTagsInfo($cid, $search = 0, $noHide = 0)
    {
        $tags_info = array();
        $category_info = Data_Mysql_Table_Product_Category::getInfoCache();
        while (!empty($category_info[$cid])) {
            if (!empty($category_info[$cid]['tags_info'])) {
                $tags_info += $category_info[$cid]['tags_info'];
            }
            $cid = $category_info[$cid][3];
        }
        if ($search) {
            foreach ($tags_info as $ck => $cv) {
                if (empty($cv['search'])) {
                    unset($tags_info[$ck]);
                }
            }
        }
        if ($noHide) {
            foreach ($tags_info as $ck => $cv) {
                if (!empty($cv['hide'])) {
                    unset($tags_info[$ck]);
                }
            }
        }
        $allTags = Data_Mysql_Table_Tags::getInfoCache();
        $returnArray = array();
        foreach ($tags_info as $ck => $cv) {
            if (!empty($allTags[$ck]['parent_id'])) {
                $returnArray[$allTags[$allTags[$ck]['parent_id']]['tags_name']][$ck] = array('tags_name' => $allTags[$ck]['tags_name'], 'tags_value' => empty($allTags[$ck]['tags_value']) ? '' : $allTags[$ck]['tags_value']);
            }
        }
        return $returnArray;
    }
}