<?php
/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/3/19 09:28
 * 收藏功能接口
 */
//获取ajax提交信息 实现收藏功能
session_start();
Core::output('');
if (empty($_SESSION['user'])) {
    echo 'alert';
    die;
} else {
    $userInfo = $_SESSION['user'];
}
$_SESSION['url_back'] = Core::$urls['referer'];
//获取用户传过来的数据
$data = Func_Input::filter(array(
    'collect_type' => 'string',
    'follow_id' => 'int',
    'user_id' => 'int',
    'action' => 'string',
    'is_cancel' => 'int',
));
$data['user_id'] = $userInfo['id'];
//判断是space或是event
if ($data['collect_type'] == 'space') {
    $sub = '_space';
} else if ($data['collect_type'] == 'event') {
    $sub = '_event';
} else if ($data['collect_type'] == 'vendor') {
    $sub = '_vendor';
} else if ($data['collect_type'] == 'set') {
    $sub = '_set';
}
//页面加载时判断用户之前是否收藏过该产品
$followInfo = Data_Mysql_Table_Follow::subTable($sub)->select('*', array('follow_id=? and user_id=?' => array($data['follow_id'], $userInfo['id'])));
if ($data['action'] == 'collect') {
    //收藏动作
    if (!empty($followInfo[0])) {
        //用户之前已收藏，更新
        $conditions = array('user_id' => $data['user_id'], 'follow_id' => $data['follow_id']);
        $rs = Data_Mysql_Table_Follow::subTable($sub)->update($conditions, array('is_cancel' => $data['is_cancel']));
    } else {
        //用户之前未收藏，添加
        $rs = Data_Mysql_Table_Follow::subTable($sub)->insert($data);
    }
    if ($sub == '_space') {
        Data_Mysql_Table_Product_Info::query('UPDATE {table} SET counter_follow = counter_follow+1 WHERE id = ?', array($data['follow_id']));
    }
} else {
    if (!empty($followInfo[0])) {
        echo $followInfo[0]['is_cancel'];
        die;
    }
}


