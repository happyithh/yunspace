<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-23
 * Time: 上午11:40
 * 询价
 */
@session_start();
$action=Core::$urls['action'];
if(!empty($action) && $action=="alert_msg"){
    //获取所有场地百科列表
//    $data=array();
//    $data=Data_Mysql_Table_Spacepedia::select("id,space_name,logo",array('status'=>1),'ORDER BY update_time DESC',5);
//    foreach($data as $k=>$v){
//        if(!empty($v['attr'])){
//            $data[$k]['attr']=json_decode($v['attr'],1);
//        }
//    }
//    Tpl_Smarty::assign('_data',$data);
    Tpl_Smarty::display( 'Web_Static::spacepedia/inquiry_alert_page.tpl');
}else{
    Tpl_Smarty::display( 'Web_Static::spacepedia/inquiry.tpl');
}
