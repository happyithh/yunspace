<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/6
 * Time: 17:53
 */
class Web_User_Center_Message extends Base
{
    static function handle()
    {
        if (empty($_SESSION['user']['id'])) {
            return false;
        }
		$conditions=array(
			"m.to_account_id = ? or m.from_account_id = ?"=>array($_SESSION['user']['id'],$_SESSION['user']['id'])
		);
		$conditions[] = '1 GROUP BY a.id ';
		$data = Data_Mysql_Table_Account::page(0, 10, 'a.id, a.username, MAX(m.send_time) AS send_time, MAX(m.read_time) AS read_time, m.from_account_id, m.to_account_id, sum(read_time=0) as c ', $conditions, ' ORDER BY m.send_time DESC', '{prefix}account AS a
LEFT JOIN {prefix}message AS m ON m.from_account_id = a.id or m.to_account_id=a.id');
		foreach($data['rows'] as $k=>$v)
		{
			if($v['username']==$_SESSION['user']['username']){
				unset($data['rows'][$k]);
			}
		}
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display('Web_User_Center', 'message.tpl');
    }
}
