<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/28
 * Time: 13:36
 *
 * 文章采集日志
 */
class Api_Wechat_Article_Log extends Api{
    static function getArticleLog($args){
        $conditions=array();
        if(!empty($args['search'])){
            $request=Func_Input::filter(array(
                'title'=>'string',
                'date_time'=>'string',
            ),$args['search']);
        }
        if(!empty($request['date_time'])){
            $date = date('_Ym',strtotime($request['date_time']));
        }else{
            $date=date('_Ym',time());
        }
        if(!empty($request['title'])){
            $conditions['title']=trim($request['title'],'');
        }
        $data = Data_Mysql_Table_Wechat_Article_Log::subTable($date)->page(0,15,'*',$conditions,'ORDER BY update_time DESC');
        return $data;
    }
}