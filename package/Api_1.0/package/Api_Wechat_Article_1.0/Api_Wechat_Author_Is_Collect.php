<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/27
 * Time: 13:10
 * 更新采集状态
 */
class Api_Wechat_Author_Is_Collect extends Api{
    static function handle()
    {
      return  self::isCollect($_REQUEST);
    }
    static function isCollect($args)
    {
        $request = Func_Input::filter(array(
            'id'=>'int',
            'collect_status'=>'int'
        ),$args);
        if(!empty($request['id']) && !empty($request['collect_status'])){
          $res =  Data_Mysql_Table_Wechat_Article_Author::update(array('id'=>$request['id']),array('collect_status'=>$request['collect_status'],'update_time'=>time()));
        }
        if(!empty($res[0])){
          return self::request('success','','状态修改失败！');
        }else{
            return self::request('error','','状态修改失败！');
        }
    }
}