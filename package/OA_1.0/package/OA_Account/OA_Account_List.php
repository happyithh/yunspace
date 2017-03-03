<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/13
 * Time: 9:47
 */
class OA_Account_List
{
    static function handle()
    {
        if (!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                "serchtext" => 'string',
                "type" => 'int',
                'end_time' => 'string',
                'start_time' => 'string',
                'account_type' => 'int',
                'source'=>'int',
            ), $_REQUEST);
            if (!empty($request['serchtext']) && isset($request['type'])) {
                switch ($request['type']) {
                    case 0:
                        $conditions['t1.username = ?'] = $request['serchtext'];
                        break;
                    case 1:
                        $conditions['t1.username =?'] = $request['serchtext'];
                        break;
                    case 2:
                        $conditions['t1.fullname =?'] = $request['serchtext'];
                        break;
                    case 3:
                        $conditions['t1.phone =?'] = $request['serchtext'];
                        break;
                    case 4:
                        $conditions['t1.email =?'] = $request['serchtext'];
                        break;
                    case 5:
                        $conditions['t1.id =?'] = $request['serchtext'];
                        break;
                    default:
                        $conditions = '';
                        break;
                }
            }
            //注册来源
            if (!empty($request['source'])) {
                if($request['source']==1){
                    $conditions['t1.admin_id = ?'] = 0;
                }else{
                    $conditions['t1.admin_id != ?'] = 0;
                }
            }
            //注册时间
            if (!empty($request['start_time']) && !empty($request['end_time'])) {
                if (strtotime($request['start_time'] . "00:00:00") > strtotime($request['end_time'] . "23:59:59")) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['t1.register_time between ? and ?'] = array(strtotime($request['start_time']."00:00:00"), strtotime($request['end_time']."23:59:59"));
                }
            } elseif (!empty($request['start_time']) && empty($request['end_time'])) {
                $conditions['t1.register_time > ?'] = strtotime($request['start_time'] . "00:00:00");
            } elseif (empty($request['start_time']) && !empty($request['end_time'])) {
                $conditions['t1.register_time < ?'] = strtotime($request['end_time'] . "23:59:59");
            }

            //只显示供应商
            if (isset($request['account_type'])) {
                $conditions['t1.account_type =?'] = 21;
            }
        }
        $conditions = !empty($conditions) ? $conditions : "";
        $account = Data_Mysql_Table_Account::page(0, 15, array('t1.id,t1.username,t1.fullname,t1.phone,t1.email,t1.register_time,t1.login_times,t2.username as adminuser'), $conditions, 'ORDER BY t1.id DESC','{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id'  );
        Tpl_Smarty::assign('_data', $account);
        Tpl_Smarty::display('OA', 'account_info.tpl');
    }
}