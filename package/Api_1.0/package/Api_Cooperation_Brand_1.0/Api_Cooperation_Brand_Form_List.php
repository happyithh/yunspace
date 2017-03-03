<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 11:54
 * 品牌入驻表单列表
 */
class Api_Cooperation_Brand_Form_List extends Api{
    static function formList($args){
        if(!empty($args['search'])){
            $search = Func_Input::filter(array(
                'company'=>'string',
                'brand'=>'string',
                'contacts'=>'string',
                'phone'=>'int',
                'start_time'=>'string',
                'end_time'=>'string',
            ),$args['search']);
            if(!empty($search['company'])){
                $conditions['company'] = $search['company'];
            }
            if(!empty($search['brand'])){
                $conditions['brand'] = $search['brand'];
            }
            if(!empty($search['contacts'])){
                $conditions['contacts'] = $search['contacts'];
            }
            if(!empty($search['phone'])){
                $conditions['phone'] = $search['phone'];
            }
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
        }
        $conditions['status !=?']=-1;
        $data = Data_Mysql_Table_Brand_Form::page(0,15,'*',$conditions,'ORDER BY create_time DESC');
        return $data;
    }
}