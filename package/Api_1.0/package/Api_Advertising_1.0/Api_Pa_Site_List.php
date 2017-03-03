<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/23
 * Time: 11:10
 * 广告位列表
 */
class Api_Pa_Site_List extends Api
{
    static function paSiteList($args)
    {
        $conditions = array();
        $status = array(
            '0' => '无',
            '1' => '有'
        );
        if (!empty($args['search'])) {
            $search = Func_Input::filter(array(
                    'site' => 'string',
                    'start_time' => 'string',
                    'end_time' => 'string'
                ), $args['search']
            );
            //创建时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time'] . '00:00:00') > strtotime($search['end_time'] . '23:59:59')) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time'] . '00:00:00'), strtotime($search['end_time'] . '23.59.59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time'] . '00:00:00');
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time'] . '23:59:59');
            }
            if (!empty($search['site'])) {
                $conditions['site'] = $search['site'];
            }
        }
        $_REQUEST['type'] = empty($_REQUEST['type']) ? 'normal' : $_REQUEST['type'];
        $type = Func_Input::filter(array(
            'type' => 'string',
        ), $_REQUEST);
        if (!empty($type['type'])) {
            if ($type['type'] == 'close') {
                $conditions['status =?'] = -1;
            } else {
                $conditions['status =?'] = 0;
            }
        }
//        q($conditions);
        $res = Data_Mysql_Table_Pa_Site::page(0, 30, "id,site,description,size,adver_city,create_time,status", $conditions, 'ORDER BY create_time DESC');
        if (!empty($res)) {
            foreach ($res['rows'] as $k => $v) {
                $res['rows'][$k]['size'] = json_decode($v['size'], 1);

                $res['rows'][$k]['adver_city'] = $status[$v['adver_city']];
            }
        }
        return $res;
    }
}