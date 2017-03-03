<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 11:05
 * 外出签到列表
 */
@session_start();
class Api_Sign_In_List extends Api{
    static function getList($args){
        if (!$_SESSION['user']) {
            $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['uri'] . '';
            Wechat_Oauth_Sale::handle();
        }
        if(!empty($_SESSION['user']['id'])){
          switch($args){
              case 'waiting':
                  $condition['status =?']=0;
                  break;
              case 'done':
                  $condition['status =?']=1;
                  break;
              case 'sign_done':
                  $condition['status =?']=2;
                  break;
              case 'reject':
                  $condition['status =?']=-1;
                  break;
          }

            $condition['account_id'] = $_SESSION['user']['id'];
            $res = Data_Mysql_Table_Sign_In::select("*",$condition,'ORDER BY create_time DESC',99);
            return $res;
        }
    }
}