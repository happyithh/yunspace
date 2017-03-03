<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/20
 * Time: 17:58
 */
class OA_Demand_getRecent
{


    //根据手机获取最近记录
    static function  getRecentDemand()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'num' => 'string',
        ), $_REQUEST);

        $recent_demand = Api_Demand_Admin_Recent::getRecent(array('phone' => $request['phone'], 'num' => $request['num']));
        if ($recent_demand) {
           /* foreach($recent_demand as $k =>$v){
                $account_ids[] = $v['account_id'];
            }
            if (!empty($account_ids)) {
                $conditions = array("id IN (" . implode(',', $account_ids) . ") ");
                $userInfo = Data_Mysql_Table_Account::select('username,id', $conditions, '', 99999999);
            }

            if ($userInfo) {
                foreach ($userInfo as $key => $value) {
                    foreach ($recent_demand as $k => $v) {
                        if ($value['id'] == $v['account_id']) {
                            $recent_demand[$k]['username'] = $value['username'];
                        }
                    }
                }
            }*/
            Tpl_Smarty::assign('recent_demand', $recent_demand);

            $tpl = Tpl_Smarty::fetch('OA_Static::demands/inc/demand_recent.tpl');
            Func_Output::json('success', $tpl, '成功');
        } else {
            Func_Output::json('error', '', '  没有最近的需求');
        }

    }
}