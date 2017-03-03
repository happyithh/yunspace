<?php
/**
 * Created by PhpStorm.
 * User: sdd
 * Date: 2016/8/17
 * Time: 16:05
 */

function getId($w_id){
    $condition['id>?'] = $w_id;
    $rs = Data_Mysql_Table_Winchance_New::select('id,active_name,online_status,space_id', $condition, '', 50);
    if(!empty($rs)){
        Export($rs);
        $w_info = end($rs);
        $w_id = (int)$w_info['id'];
        getId($w_id);
    }else{
        Q("执行完成'");
    }
}

function Export($rs){
    foreach($rs as $k=>$v){
        if(!empty($v['space_id'])){
            continue;
        }
        $space_data = array(
            'space_name'=>$v['active_name'],
            'status'=>$v['online_status'],
            'category_id'=>200
        );
        $result= Data_Mysql_Table_Spacepedia::update($space_data);
        if($result){
             Data_Mysql_Table_Winchance_New::update(array('id=?'=>$v['id']),array('space_id'=>$result[0]));
        }else{
            continue;
        }

    }
}
getId(0);
