<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/9/22
 * Time: 10:17
 */
class Api_Retail_Adm_List extends Api{
    static function handle(){
        return self::admList();
    }
    static function admList(){
        $condition['status']=1;
        $condition['type']=2;
        $data = Data_Mysql_Table_Cooperation_Brand::page(0,9,'id,logo,title',$condition,'ORDER BY update_time DESC');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                $data['rows'][$k]['url'] = 'http://'.Core::$urls['host'].'/adm/'.Func_NumEncode::e($v['id']).'.html';
            }
        }
        return self::request('success',$data['rows'],'');
    }
}