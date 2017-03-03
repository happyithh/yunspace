<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 10:26
 * 需求标签表
 */
class Data_Mysql_Table_Demand_Tag extends Data_Mysql_Table
{
    public $cols = array(
        'tag_value' => 'string',     //tag标签值
        'admin_id' => 'int',         //标签创建人
        'create_time' => 'int',         //标签创建时间
        'update_time' => 'int',         //标签修改时间
    );

    public $index = array(
//        'key' => 'i',
        'tag_value' => 'u',
        'admin_id' => 'i',
    );

    /**
     * @param $args
     * @return array|bool
     * 转换标签
     */
    static function  convertVal($args)
    {
        $ids = array();
        $tagsVal = array();
        if (is_array($args)) {
            $ids[] = array_keys($args);
            if (empty($ids[0])) {
                return false;
            }
            $where[] = "id IN(" . @implode(',', $ids[0]) . ")";
            $data = self::select('id,tag_value', $where, '', 50);
            foreach ($data as $key => $val) {
                if (isset($args[$val['id']])) {
                    $tagsVal[$val['id']] = $val['tag_value'];
                }
            }
            return $tagsVal;
        }
        return array();
    }


    /**
     * @param $args
     * @return array|bool
     * 标签转换成id
     */
    static function  convertKey($args)
    {
        $tag_value = array();
        $tagsVal = array();
        if (is_array($args)) {
            $tag_value[] = array_keys(array_flip($args));

            if (empty($tag_value[0])) {
                return false;
            }
            $whereString = '';
            foreach ($tag_value[0] as $val) {
                $whereString = $whereString . "'" . $val . "',";
            }
            $where[] = "tag_value IN(" . mb_substr($whereString, 0, -1, 'utf-8') . ")";

            $data = self::select('id,tag_value', $where, '', 50);

            foreach ($data as $key => $val) {
                $tagsVal[$val['id']] = $val['tag_value'];
            }
            return $tagsVal;
        }
        return array();
    }

    /**
     * 调出随机标签
     */
    static function  getRandTags()
    {
        $data = Data_Mysql_Table_Demand_Tag::select('id,tag_value', array(), 'ORDER BY create_time DESC', 5);
        return $data;
    }
}
