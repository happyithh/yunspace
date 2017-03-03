<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/17
 * Time: 17:26
 * 评论列表 点赞
 * $args = array(
 *
 * comments_id => 评论id,
 *
 * )
 *
 *
 *
 */
class Api_Comments_CreateZan extends Api{
    static function handle($args){
        return self::createZan($args);
    }
    static function createZan($args){
        $request = Func_Input::filter(array(
            'comments_id'=>'int',
        ),$args);
//        Data_Mysql_Table_Comments::debug(1);
       $data =  Data_Mysql_Table_Comments::query(
            'UPDATE {table} SET is_good = is_good +1 WHERE id ='.Func_NumEncode::d($request['comments_id'])
        );
        return self::request('success',$data,'点赞成功');
    }
}