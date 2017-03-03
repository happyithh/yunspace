<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/7
 * Time: 20:34
 */

class OA_Winchance_Fields_Manage {
    static function handle()
    {
        /*
         * 添加字段表添加字段
         * */
        $new_array = array(
            'country'=>'来源国家',
            'category'=>'分类',
            'manifestation'=>'表现形式',
            'city'=>'运营范围',
            'cooperating_mode'=>'合作模式'
        );
        foreach($new_array as $k=>$v){
            $data = Data_Mysql_Table_Winchance_Fields::select('*',array('field'=>$k));
            if(empty($data[0])){
                Data_Mysql_Table_Winchance_Fields::insert(array('field'=>$k,'name'=>$v));
            }
        }
        /*
         *  结束
         * */


        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::fieldsList();
                break;
        }
    }
    static function fieldsList(){
        $data = Api_Winchance_New_Field::fieldList();
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display("OA_Static::winchance_new/fields_list.tpl");
    }
} 