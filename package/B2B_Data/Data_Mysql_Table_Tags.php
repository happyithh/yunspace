<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Tags extends Data_Mysql_Table
{
    public $cols = array(
        'parent_id' => 'int',
        'category_id' => 'int',
        'tags_name' => '50',
        'tags_type' => 'int',
        'tags_value' => 'text',
        'sort_weight' => 'tinyint',
        'status' => 'tinyint',
    );
    public $index = array(
        'parent_id,tags_name' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'sort_weight' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "全局标签",                                                     //空键,表名
        'parent_id' => '父级ID',
        'category_id' => '分类ID',
        'tags_name' => '标签名',
        'sort_weight' => '排序优先级',
        'tags_type' => '标签类型',// 0单选 1多选
        'tags_value' => '标签的值',
    );
    public $filter = array(
        'status' => array(
            3 => '回收站',//删除
            2 => '停用', //隐藏
            1 => '正常',
        ),
    );

    static function getIdsCache()
    {
        $tags = Data_Mysql_Table_Tags::getTreeCache();
        $allTags = array();
        foreach ($tags as $v) {
            $allTags += $v;
        }
        return $allTags;
    }

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
        return $data;
    }

    function ___tagsToId()
    {
        $data = Core::readData(Core::$paths['temp'] . get_called_class() . '.ids');
        if (!$data) {
            $rs = self::updateCache();
            $data = $rs['ids'];
            $data['-1'] = true;
        }
        return $data;
    }

    static function updateCache()
    {
        $data = array('info' => array(), 'tree' => array(), 'ids' => array());
        $rs = Data_Mysql_Table_Tags::select('*', '', 'ORDER BY parent_id ASC, sort_weight DESC', 500);
        if (!empty($rs)) {
            foreach ($rs as $r) {
                //info
                $data['info'][$r['id']]['id'] = $r['id'];
                $data['info'][$r['id']]['tags_name'] = $r['tags_name'];
                $data['info'][$r['id']]['parent_id'] = $r['parent_id'];
                $data['info'][$r['id']]['status'] = $r['status'];
                $data['info'][$r['id']]['tags_type'] = $r['tags_type'];
                if (!empty($r['tags_value'])) {
                    $tag_value = explode(",", $r['tags_value']);
                    $data['info'][$r['id']]['tags_value'] = $tag_value;
                }
                //tree
                $data['tree'][$r['parent_id']][$r['id']] = $r['status'] == 1 ? $r['tags_name'] : '';
                if ($r['parent_id']) {
                    $data['ids'][$data['info'][$r['parent_id']]['tags_name'] . '>' . $r['tags_name']] = $r['id'];
                } else {
                    $data['ids'][$r['tags_name']] = $r['id'];
                }
            }
            Core::writeData(Core::$paths['temp'] . get_called_class() . '.tree', $data['tree'], 99999999);
            Core::writeData(Core::$paths['temp'] . get_called_class() . '.info', $data['info'], 99999999);
            Core::writeData(Core::$paths['temp'] . get_called_class() . '.ids', $data['ids'], 99999999);
        }
        return $data;
    }

    static function clearCache()
    {
        Core::writeData(Core::$paths['temp'] . get_called_class() . '.tree', '', 99999999);
        Core::writeData(Core::$paths['temp'] . get_called_class() . '.info', '', 99999999);
        self::exec('UPDATE {table} SET attr_cache = "" WHERE 1');
    }

    static function getTagsId($tagsName, $defaultValues = '')
    {
        if (!$tagsName) {
            return null;
        }
        $tags = self::getInstance()->___tagsToId;
        if (empty($tags[$tagsName])) {
            $attr_arr = explode('>', $tagsName);
            if (empty($attr_arr[1])) {
                $tagsName = '基本信息>' . $tagsName;
                $attr_arr = explode('>', $tagsName);
            }
            if (empty($tags[$tagsName])) {
                if (empty($tags[$attr_arr[0]])) {
                    $newData = array('parent_id' => 0, 'tags_name' => $attr_arr[0], 'status' => 1);
                    $p_rs = Data_Mysql_Table_Tags::insert($newData);
                    if (empty($p_rs[0])) {
                        return null;
                    }
                    $tags[$attr_arr[0]] = $p_rs[0];
                }
                $newData = array('parent_id' => $tags[$attr_arr[0]], 'tags_name' => $attr_arr[1], 'tags_value' => $defaultValues, 'status' => 1);
                $p_rs = Data_Mysql_Table_Tags::insert($newData);
                if (empty($p_rs[0])) {
                    return null;
                }
                $tags[$tagsName] = $p_rs[0];
                self::getInstance()->___tagsToId = $tags;
            }
        }
        return $tags[$tagsName];
    }

    static function getTagsByIds($ids = array(), $son_name = 1)
    {
        $tags = array();
        $tags_tree = self::getTreeCache();
        $tags_info = self::getInfoCache();
        foreach ($ids as $k => $v) {
            if (!empty($tags_info[$v])) {
                $parent_name = $tags_tree[0][$tags_info[$v]['parent_id']];
                if (!empty($son_name)) {
                    $tags[$parent_name][$tags_info[$v]['tags_name']] = $tags_info[$v];
                } else {
                    $tags[$parent_name][$tags_info[$v]['id']] = $tags_info[$v];
                }
            }
        }
        return $tags;
    }

    static function updateTagsByAttr($name, $tags_value)
    {
        if (!$name) {
            return null;
        }
        $return = 0;
        $attr_arr = explode('>', $name);
        if (empty($attr_arr[1])) {
            $attr_arr = explode('>', '基本信息>' . $name);
        }
        q(self::getInstance()->___tagsToId);
        q($attr_arr);
        $parent_name = $attr_arr[0];
        $parent_rs = Data_Mysql_Table_Tags::select('*', array('tags_name' => $parent_name));
        if (empty($parent_rs[0])) {
            $parent_data = array('parent_id' => 0, 'tags_name' => $parent_name, 'status' => 1);
            $p_rs = Data_Mysql_Table_Tags::insert($parent_data);
            if (!empty($p_rs[0])) {
                if (!empty($attr_arr[1])) {
                    $son_data = array('parent_id' => $p_rs[0], 'tags_name' => $attr_arr[1], 'tags_value' => $tags_value, 'status' => 1);
                    $rs = Data_Mysql_Table_Tags::insert($son_data);
                    $return = $rs[0];
                }

            }
        } else {
            if (!empty($attr_arr[1])) {
                $son_rs = Data_Mysql_Table_Tags::select('*', array('tags_name' => $attr_arr[1], 'parent_id' => $parent_rs[0]['id']));
                if (empty($son_rs[0])) {
                    $son_data = array('parent_id' => $parent_rs[0]['id'], 'tags_name' => $attr_arr[1], 'tags_value' => $tags_value, 'status' => 1);
                    $rs = Data_Mysql_Table_Tags::insert($son_data);
                    $return = $rs[0];
                } else {
                    $return = $son_rs[0]['id'];
                }
            }
        }
        self::updateCache();
        return $return;
    }

}