<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/21
 * Time: 9:56
 *
 *  微信作者（公众号） 置顶 或 取消置顶
 */
class Api_Wechat_Author_Update_Status extends Api{
    static function updateStatus($args)
    {
        $request =Func_Input::filter(array(
            'id'=>'int',
            'status'=>'int'
        ),$args);
        if(!empty($request['id'])){
            $data = Data_Mysql_Table_Wechat_Article_Author::update(array('id'=>$request['id']),array('status'=>$request['status']));
            if(!empty($data[0])){
                return self::request('success','','操作成功！');
            }else{
                return self::request('error','','更新失败！');
            }
        }else{
            return self::request('error','','ID为空!');
        }
    }
}