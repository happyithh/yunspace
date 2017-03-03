<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/20
 * Time: 15:54
 *
 * 微信文章作者的统计信息
 *
 */
class Api_Wechat_Article_Author_Trace extends Api{
    static function updateAuthorInfo($args)
    {
        $request = Func_Input::filter(array(
            'author'=>'string',
            'type'=>'string',
        ),$args);
        if(!empty($request['author']) && !empty($request['type'])){
            switch($request['type']){
                case 'is_good':
                    $str = 'suggest_sum';
                    break;
                case 'is_bad':
                    $str = 'bad_sum';
                    break;
                case '2':
                    $str = 'user_sum';
                    break;
                case '1':
                    $str = 'suggest_sum';
                    break;
                case '-1':
                    $str = 'hide_sum';
                    break;
            }
            $time = time();
            Data_Mysql_Table_Wechat_Article_Author::query( 'INSERT INTO {table} (author,'.$str.',create_time) VALUES ("'.$request['author'].'",1,'.$time.')  ON DUPLICATE KEY UPDATE '.$str.' = '.$str.' +1');
        }
    }
}