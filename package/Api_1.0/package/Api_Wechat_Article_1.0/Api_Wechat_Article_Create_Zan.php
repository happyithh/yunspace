<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/19
 * Time: 13:22
 *
 * 微信文章点赞
 */
class Api_Wechat_Article_Create_Zan extends Api {
    static function handle($args){
        return self::createZan($args);
    }
    static function createZan($args){
        $request = Func_Input::filter(array(
            'id'=>'int',
            'type'=>'int',
            'author'=>'string'
        ),$args);
//        Data_Mysql_Table_WeChat_Article::debug(1);
        if(!empty($request['type']) && $request['type']==1){
           $data= Data_Masql_Table_WeChat_Article::query(
                'UPDATE {table} SET is_bad = is_bad +1 WHERE id = ?',
                array(
                    $request['id']
                ),1
            );
            $args['type']='is_bad';
        }else{
            $data=Data_Masql_Table_WeChat_Article::query(
                'UPDATE {table} SET is_good = is_good +1,status=1 WHERE id = ?',
                array(
                    $request['id']
                ),1
            );

            $args['type']='is_good';
        }
        if(!empty($data[0])){
            $args['author']=$request['author'];
            Api_Wechat_Article_Author_Trace::updateAuthorInfo($args);
          return self::request('success','','操作成功');
        }else{
            return self::request('error','','操作成功');
        }

    }
}