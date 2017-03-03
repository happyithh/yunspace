<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/27
 * Time: 11:04
 * 写入公众号url
 */
class Api_Wechat_Author_Insert_Url extends Api{
    static function handle($args){
        return self::insertUrl($_REQUEST);
    }
    static function insertUrl($args){
        $request =Func_Input::filter(array(
            'id'=>'int',
            'url'=>'string',
            'ext'=>'string',
        ),$args);
        if(!empty($request['id']) && !empty($request['url'])){
            $res = Data_Mysql_Table_Wechat_Article_Author::update(array('id'=>$request['id']),array('url'=>$request['url'].'&ext='.$request['ext'],'update_time'=>time()));
            if(!empty($res[0])){
                return self::request('success','','URL写入成功!');
            }else{
                return self::request('error','','URL写入失败!');
            }
        }else{
            return self::request('error','','未获取公众号ID!');
        }
    }
}