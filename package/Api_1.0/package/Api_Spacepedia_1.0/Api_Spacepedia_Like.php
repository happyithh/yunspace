<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/15
 * Time: 19:04
 * 百科 写入我喜欢
 */
@session_start();

class Api_Spacepedia_Like extends Api
{
    static function createLike($args)
    {
        $request = Func_Input::filter(array(
            'space_id' => 'int',
            'space_name'=>'string',
            'like_go'=>'string',
        ), $args);
        if (!empty($_SESSION['wechat_id'])) {
            $data['wechat_id'] = $_SESSION['wechat_id'];
            $data['space_id'] = $request['space_id'];
            if($request['like_go']=="Go"){
                //现场足迹
                $data['like_go'] = 2;
            }else{
                //我喜欢
                $data['like_go'] = 1;
            }
            $data['create_time']=time();
            $res = Data_Mysql_Table_Like_Go::update($data);
            //更新缓存为空
            Api_Common_Cache::set("like_go",$request['space_id'],'');
            if (!empty($res[0])) {
                if($request['like_go']=="Go"){
                    Data_Mysql_Table_Baike_Statistical::query(
                        'INSERT INTO {table} (space_id) VALUES (?)  ON DUPLICATE KEY UPDATE is_go = is_go +1',
                        array(
                            $request['space_id']
                        )
                    );
                }else{
                    Data_Mysql_Table_Baike_Statistical::query(
                        'INSERT INTO {table} (space_id) VALUES (?)  ON DUPLICATE KEY UPDATE is_love = is_love +1',
                        array(
                            $request['space_id']
                        )
                    );
                }
            }
        }
    }

}