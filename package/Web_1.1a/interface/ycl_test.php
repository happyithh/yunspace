<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2016/1/6
 * Time: 22:38
 */

//给所有年会投票的用户加上5积分，另外给投票度假旅游（year_id=2）的用户另外加50积分；
$rs_a = Data_Mysql_Table_YearMeeting_Vote::select('user_id',array('year_id !=?'=>2),'',212);
$rs_b = Data_Mysql_Table_YearMeeting_Vote::select('user_id',array('year_id =?'=>2),'',141);

$rs_a_new = $rs_b_new = array();
foreach($rs_a as $k=>$v) {
    $rs_a_new[] = $v['user_id'];
}
foreach($rs_b as $k=>$v) {
    $rs_b_new[] = $v['user_id'];
}
Data_Mysql_Table_Account::query('UPDATE {table} SET integral=integral+5 WHERE id IN ('.implode(',',$rs_a_new).')');
Data_Mysql_Table_Account::query('UPDATE {table} SET integral=integral+55 WHERE id IN ('.implode(',',$rs_b_new).')');
