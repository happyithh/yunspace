<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/1
 * Time: 14:38
 * 需求标签列表
 */
class Api_Demand_Offer_Tag_List extends Api
{
    static function getTagList($args)
    {
        $conditions = array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'tag_value'=>'string',
//                'start_time'=>'string',
//                'end_time'=>'string',
            ),$_REQUEST['search']);
            if(!empty($search['tag_value'])){
                $conditions['{table}.tag_value=?']=$search['tag_value'];
            }
//            if(!empty($search['start_time']) && !empty($search['end_time'])){
//                if(strtotime($search['start_time'])>strtotime($search['end_time'])){
//                    return self::request('error','','请选择正确时间范围!');
//                }else{
//                    $conditions['create_time between ? and ?']=array(strtotime($search['start_time'].'00:00:00'),strtotime($search['end_time']."23:59:59"));
//                }
//            }
//            if(!empty($search['start_time']) && empty($search['end_time'])){
//                $conditions['create_time >= ?']=strtotime($search['start_time']."00:00:00");
//            }
//            if(empty($search['start_time']) && !empty($search['end_time'])){
//                $conditions['create_time <=?']=strtotime($search['end_time']."23:59:59");
//            }
        }
//        q($conditions);
//        Data_Mysql_Table_Demand_Tag::debug(1);
        $res = Data_Mysql_Table_Demand_Tag::page(0, 15, '{table}.id,tag_value,create_time,{prefix}administrator.fullname', $conditions, 'ORDER BY create_time DESC', '{table} LEFT JOIN {prefix}administrator ON {table}.admin_id={prefix}administrator.id');
//        q($res);
        return self::request('success',$res,'');

    }
}