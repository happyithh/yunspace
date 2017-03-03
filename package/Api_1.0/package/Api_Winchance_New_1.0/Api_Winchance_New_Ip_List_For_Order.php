<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/10
 * Time: 9:15
 */
class Api_Winchance_New_Ip_List_For_Order extends Api{
    static function handle(){
        return self::ipList();
    }
    static function ipList(){
        $request= $request = Func_Input::filter(array(
            'q'=>'string',
        ),$_REQUEST);
        if(!empty($request['q'])){
            $conditions[] ="active_name like '%".$request['q']."%'";
        }
        $conditions['status =?'] =1;
        $data = Data_Mysql_Table_Winchance_New::select('id,active_name',$conditions,'',2000);
        if(empty($data)){
            return false;
        }else{
            $new_data=array();
            foreach($data as $k=>$v){
                $new_data[$k]['id']=$v['active_name'];
                $new_data[$k]['name']=$v['active_name'];
            }
            return $new_data;
        }

    }

}