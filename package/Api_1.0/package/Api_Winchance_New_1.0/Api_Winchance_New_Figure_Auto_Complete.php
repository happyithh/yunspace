<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 13:19
 * 公司名称搜索  自动完成
 */
@session_start();
class Api_Winchance_New_Figure_Auto_Complete extends Api
{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        }else{
            return self::figureSearch();
        }
    }

    static function figureSearch()
    {
        $request = Func_Input::filter(array(
            'q' => 'string',
            'company'=>'string',
        ), $_REQUEST);
        $conditions['status !=?'] = -1;
        if (!empty($request['q'])) {
            $conditions['name like ?'] = $request['q'] . '%';
            $conditions['company =?'] = $request['company'];
            $data = Data_Mysql_Table_Winchance_Figure::select('*', $conditions, 'ORDER BY create_time DESC', 10);
        }
        $dataNew = array();
        if(!empty($data)){
          foreach($data as $k=>$v){
             $dataNew['results'][$k]['name']=$v['name'];
             $dataNew['results'][$k]['id']=$v['name'];
          }
        }
        return $dataNew;

    }
}