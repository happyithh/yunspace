<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/1
 * Time: 15:46
 */
session_start();
if (!empty($_SESSION['user']['id'])) {
    Tpl_Smarty::assign('__user', $_SESSION['user']);
    $conditions = array(
        "to_account_id" => array($_SESSION['user']['id']),
    );
    $message_num = Data_Mysql_Table_LiveChat_Message_Recent::select('sum(total) as c, id', $conditions);
    if (empty($message_num[0]['id'])) {
        Api_Livechat_Message_SendDefaultMessage::sendSystemNotice1($_SESSION['user']['id']);
        $message_num['0']['c'] = 1;
    }
    Tpl_Smarty::assign('message_num', $message_num['0']['c']);
}
Tpl_Smarty::display('Web_Static::v2.0/ajax-ustat_v2.tpl');