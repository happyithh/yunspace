<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/3
 * Time: 18:01
 * 合作品牌列表
 */
class Api_Cooperation_Brand_List extends Api{
    static function brandList($type){
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'start_time'=>'string',
                'end_time'=>'string',
                'status'=>'int'
            ),$_REQUEST['search']);
            if(!empty($search['title'])){
                $conditions['title'] = $search['title'];
            }
            if(!empty($search['status'])){
                if($search['status']==1){
                    $conditions['status']=1;
                }elseif($search['status']==-2){
                    $conditions['status']=-1;
                }else{
                    $conditions['status']=0;
                }
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
        if(empty($search['status'])){
            $conditions['status != ?'] =-1;
        }
        $conditions['type = ?'] =$type;
        $data = Data_Mysql_Table_Cooperation_Brand::page(0,15,'*',$conditions,'ORDER BY create_time DESC');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                if(!empty($v['attr'])){
                    $data['rows'][$k]['attr'] = json_decode($v['attr'],1);
                }
            }
        }
        return $data;
    }
}