<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/27
 * Time: 16:15
 * 是否创建群组
 */
class Api_Demand_isGroup extends Api
{
    /**
     * @传入参数  $args = array(
     *              demand_id =>'',     需求ID
     *
     * )
     *返回值 array()
     *
     *
     */
    static function  isGroup($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int'
        ), $args);

        $demand = Data_Mysql_Table_Demand::select('id,account_id,response_account_id,group_id', array('id =?' => $request['demand_id']));
        if (empty($demand[0]['id'])) {
            return false;
        }
        if (empty($demand[0]['group_id'])) {
            $conditions[] = "id IN(" . $demand[0]['account_id'] . ',' . $demand[0]['response_account_id'] . ")";
            $account = Data_Mysql_Table_Account::select('id,username', $conditions, '', 2);
            $members[] = array(
                'account_id' => '',
                'username' => '',
            );
            foreach ($account as $val) {
                $members[] = array(
                    'account_id' => $val['id'],
                    'username' => $val['username'],
                );
            }
            $status = Api_Livechat_Group_Create::handleCreate(array('demand_id' => $request['demand_id'], 'members' => $members));
            if (!empty($status['data']['group_id'])) {
                return Data_Mysql_Table_LiveChat_Group::convertToAccountId($status['data']['group_id']);
            }
        } else {
            return Data_Mysql_Table_LiveChat_Group::convertToAccountId($demand[0]['group_id']);
        }

        return false;

    }

}
