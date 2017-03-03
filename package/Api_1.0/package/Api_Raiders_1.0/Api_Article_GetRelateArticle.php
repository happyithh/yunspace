<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/6/20
 * Time: 10:23
 * 获取相关文章
 */
class Api_Article_GetRelateArticle extends Api
{


    /**
     * @param $args
     * @return array
     * 获取推荐文章
     *
     * 文章规则  1，关键词  2，id约束  3，时间约束 {最新}
     */
    static function  getRelationArticle($args)
    {
        $data_a = $data_b = array();
        $request = Func_Input::filter(array(
            'tags_info' => 'string',
            'id' => 'int',
            'baike_cid' => 'string',
        ), $args);
        $cols = 'id,title,logo,des,counter_view,counter_praise,status,create_time';
        if (empty($request['tags_info']) && empty($request['id']) && empty($request['category_id'])) {

            return Data_Mysql_Table_Raiders_Info::select($cols, array('status=? AND logo !=?' => array(1, '')),
                'ORDER BY create_time DESC', 5);
        }
        if (!empty($request['tags_info']) && !empty($request['id'])) {
            $conditions_a['tags_info'] = $request['tags_info'];
            $conditions_a['status=? AND logo !=? AND id<?'] = array(1, '', $request['id']);
            $data_a = Data_Mysql_Table_Raiders_Info::select($cols, $conditions_a,
                'ORDER BY create_time DESC',
                5);

            if (count($data_a) == 5) {
                return $data_a;
            }
        }
        //数量小于5
        if (!empty($request['id']) && !empty($request['baike_cid']) && count($data_a) < 5) {

            $conditions_b['id <? AND status=? AND logo !=?'] = array($request['id'], 1, '');
            $conditions_b['baike_cid'] = $request['baike_cid'];
            $data_b = Data_Mysql_Table_Raiders_Info::select($cols, $conditions_b, 'ORDER BY create_time DESC',
                5 - count($data_a));
            return array_merge($data_b, $data_a);
        }
        //只存在ID
        if (!empty($request['id'])) {
            $conditions_c['status=? AND　id <? AND logo !=?'] = array(1, $request['id'], '');
            return Data_Mysql_Table_Raiders_Info::select($cols, $conditions_c, 'ORDER BY create_time DESC',
                5);
        }
        return array();

    }


    /**
     * 获取热门标签
     * 规则
     *  加推荐的
     */
    static function  getHotTags($type = '')
    {
        if (!empty($type) && $type > 1) {
            $c_id = 112;
            if ($type == 112) {
                $space_c_id = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
                $ids[] = 112;
                $ids = array_keys($space_c_id);
                $c_id = implode(',', $ids);
            } else {
                $c_id = $type;
            }
            $conditions['baike_cid'] = $c_id;
        }
        $conditions['status=?'] = array(1);
        $conditions['tags_info !=?'] = '';
        $data = Data_Mysql_Table_Raiders_Info::select('id,tags_info,counter_view', $conditions,
            'ORDER BY create_time DESC', 200);
        if (!empty($data[0])) {
            //按照浏览量排序！
            foreach ($data as $v) {
                $counter_view[] = $v['counter_view'];
            }
            array_multisort($counter_view, SORT_DESC, SORT_NUMERIC, $data);
            $tags_array = array();
            foreach ($data as $key => $val) {
                $tags_array[Func_NumEncode::e($val['id'])] = json_decode($val['tags_info'], 1);
            }
            $tags = array();

            foreach ($tags_array as $key => $vv) {

                foreach ($vv as $k => $v) {
                    $tags[$v] = $key;
                }
            }
            return array_splice($tags, 0, 16);
        }

    }

    /**
     * 对二维数组进行排序
     * @param $array
     * @param $keyid 排序的键值
     * @param $order 排序方式 'asc':升序 'desc':降序
     * @param $type  键值类型 'number':数字 'string':字符串
     */
    static function sort_array(&$array, $keyid, $order = 'asc', $type = 'number')
    {
        if (is_array($array)) {
            foreach ($array as $val) {
                $order_arr[] = $val[$keyid];
            }
            $order = ($order == 'asc') ? SORT_ASC : SORT_DESC;
            $type = ($type == 'number') ? SORT_NUMERIC : SORT_STRING;
            array_multisort($order_arr, $order, $type, $array);
        }
    }

} 