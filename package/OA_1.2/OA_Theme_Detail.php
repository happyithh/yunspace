<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/5/19
 * Time: 9:45
 * 专题详情
 */
class OA_Theme_Detail extends Web_Global{

    function theme_id(){
        if(empty($_REQUEST['theme_id'])){
            Func_Header::notFound();
        }
        return $_REQUEST['theme_id'];
    }

    function themeDetail(){
        $themeDetail=Api_Theme_Info::getThemeInfoById($this->theme_id);
        return $themeDetail;
    }
}