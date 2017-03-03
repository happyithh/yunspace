<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/15
 * Time: 9:52
 *
 *
 * 写入评论

 */
/**
 *
 * account_id => 用户ID
 * space_id  => 百科ID
 * article_id => 文章 ID (PC)
 * comments_id=> 评论的父级ID
 * content => 评论内容
 *
*/
@session_start();
class Api_Comments_Create extends Api{
    static function handle($args){
        return self::createComments($_REQUEST);
    }
    static function createComments($args){
        $request = Func_Input::filter(array(
//            'parent_id'=>'int',
            'space_id'=>'int',
            'article_id'=>'int',
            'comments_id'=>'int',
            'content'=>'string',
        ),$args);
        if(empty($_SESSION['user']['id'])){
            return self::request('error','','您的账户异常，请重新登录！');
        }
        if(empty($request['space_id'])){
            return self::request('error','','请给相关百科进行评论！');
        }
        $request['content']=trim($request['content']);
        if(empty($request['content'])){
            return self::request('error','','评论内容不能为空！');
        }
        $data['account_id']=isset($_SESSION['user']['id'])?$_SESSION['user']['id']:'';
        $data['wechat_id']=isset($_SESSION['wechat_id'])?$_SESSION['wechat_id']:'';
        $data['phone']=isset($_SESSION['user']['phone'])?$_SESSION['user']['phone']:'';
        $data['space_id']=$request['space_id'];
        $data['article_id']=empty($request['article_id'])?0:$request['article_id'];
        $data['content']=$request['content'];
        $data['create_time']=time();
        $data['ip']=Func_Input::ip();
//        $data['parent_id']=empty($request['parent_id'])?0:$request['parent_id'];
        $data['comments_id']=empty($request['comments_id'])?0:$request['comments_id'];
//        Data_Mysql_Table_Comments::debug(1);
        $res = Data_Mysql_Table_Comments::insert($data);
       if(empty($request['comments_id'])){
           Data_Mysql_Table_Baike_Statistical::query(
               'INSERT INTO {table} (space_id, comments) VALUES ('.$request['space_id'].',1)  ON DUPLICATE KEY UPDATE comments = comments +1');
       }
//        q($request['comments_id']);
        if(!empty($request['comments_id'])){
//            Data_Mysql_Table_Comments::debug(1);
            Data_Mysql_Table_Comments::query(
                'UPDATE {table} SET count_reply = count_reply +1 WHERE id = '.$request['comments_id']);
        }
        if(!empty($res)){
            $data["id"]=Func_NumEncode::e($res[0]);
            return self::request('success',$data,'评论成功！');
        }else{
            return self::request('error','','评论失败！');
        }
    }
}