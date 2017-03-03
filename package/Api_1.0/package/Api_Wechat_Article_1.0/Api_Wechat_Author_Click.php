<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/21
 * Time: 10:49
 * 搜狗下的 微信公众号浏览量
 */
class Api_Wechat_Author_Click extends Api
{
    static function handle(){
      return  self::getClick($_REQUEST);
    }
    static function getClick($args){
        $request = Func_Input::filter(array(
            'author'=>'string'
        ),$args);
        $time=time();
        Data_Mysql_Table_Wechat_Article_Author::query('INSERT INTO {table} (author,click_sum,create_time) VALUES ("'.$request['author'].'",1,'.$time.')  ON DUPLICATE KEY UPDATE click_sum = click_sum +1',1);
        return self::request('success','','跳转成功！');


    }
}