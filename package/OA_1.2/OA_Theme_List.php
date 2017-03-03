<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/5/19
 * Time: 9:45
 */
class OA_Theme_List extends Web_Global{

    function conditions(){
        $conditions=array();
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'url_name'=>'string',
                'create_time'=>'string',
                'status'=>'int',
            ),$_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['id = ?'] = $search['title'];
                } else {
                    $conditions['theme_name'] =$search['title'];
                }
            }
            if (!empty($search['url_name'])) {
                $conditions['url_name'] =$search['url_name'];
            }

            //创建时间筛选
            if(!empty($search['create_time'])){
                $conditions['create_time >= ?'] =strtotime($search['create_time']);
            }
            if(isset($search['status']) && $search['status'] != 9999){
                $conditions['status'] =$search['status'];
            }
        }

        return $conditions;
    }

    function status(){
        return Data_Mysql_Table_Theme::$status;
    }

    function themeList(){
        $themeList=Api_Theme_List::getThemeList($this->conditions,1);
        return $themeList;
    }
}