<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/20
 * Time: 17:42
 *
 * 微信公众号 列表
 */
class Api_Wechat_Article_Author_List extends Api{
    static function authorList($args){
        $request =Func_Input::filter(array(
            'type'=>'string',
        ),$args);
        if($request['type']=='all'){
            $request['type']='status';
        }
        $data = Data_Mysql_Table_Wechat_Article_Author::page(0,15,'*','','ORDER BY status DESC,'.$request['type'].' DESC,create_time DESC');
        return $data;
    }
}