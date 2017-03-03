<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 15:30
 * 外出签到列表
 */
class Web_Moblie_Sign_In_Management extends Page_Base
{
    // 获取签到列表
    function signInList()
    {
        return Api_Sign_In_List::getList($this->signStatus);
    }

    // 获取详情列表
    function signInDetail()
    {
        if(strstr(Core::$urls['action'],'detail/')){
            $_REQUEST['id'] = explode('detail/',Core::$urls['action']);
            $_REQUEST['id']=$_REQUEST['id'][1];
            return Api_Sign_In_Detail::getDetail($_REQUEST['id']);
        }
    }

    // 获取签到状态
    function signStatus()
    {
        $status = !empty(Core::$urls['action'])?Core::$urls['action']:'list/status_all';
        if(strstr($status,'list/status_')){
            $status = explode('status_',$status);
//            q($status);
            return $status[1];
        }

    }
}