<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/23
 * Time: 16:15
 * @分配需求
 * 1.将销售人员加入到群组中
 */
@session_start();
class  Api_Demand_Allot extends Api
{

    /**
     *
     * @接受的参数
     *      $args = array(
     *          'response_account_id'
     *          'demand_id'
     *          'admin_id'
     * )
     *
     * @返回参数
     *      返回状态status （0，返回未成功，1返回成功），
     *      状态消息msg ：返回成功 或返回失败原因
     *      返回值 data:''
     *
     *
     */
    static function  handle($args = '')
    {
        return self::allot($args);
    }

    static function  allot($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'admin_id' => 'int',
            'response_account_id' => 'int',
        ), $args);
        if (empty($request['response_account_id']) && !empty($request['admin_id'])) {
          $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$request['admin_id']));
            if(!empty($administratorAccount['account_id'])){
                $request['response_account_id'] =$administratorAccount['account_id'];
            }else{
                return self::request('error','','没有负责人的帐户信息');
            }
        } elseif (empty($request['demand_id']) || empty($request['admin_id'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数的合法性！');
        }

        $demand_up = Data_Mysql_Table_Demand::update(array('id =?' => $request['demand_id']),
            array('response_account_id' => $request['response_account_id'],
                'admin_id' => $request['admin_id']));
        if ($demand_up[0] == 0) {
           return Api::request('error', '', '分配负责人失败');
        }

        $group_id = Api_Demand_isGroup::isGroup(array('demand_id' => $request['demand_id']));
        if ($group_id) {
            $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $request['admin_id']));
            if ($account) {
                $members = array(array(
                    'account_id' => $account['account_id'],
                    'username' => $account['username'],
                ));
                Api_Livechat_Group_AddMember::handleAddMember(array(
                    'group_id' => $group_id,
                    'members' => $members,
                ));
                Api_Demand_Notice::noticeSalePersonnel(array('demand_id' => $request['demand_id'], 'email' => $account['email'], 'account_id' => $account['account_id']));

            }
        }
        $vas =Data_Mysql_Table_Demand::select("account_id,demand_type",array('id =?' => $request['demand_id']));
        // 文创项目合作同步更新
        if($vas[0]['demand_type']=='文创项目合作'){
            Api_Winchance_Online_Site_Create::WinchanceSiteCreate($request['demand_id']);
        }
        Data_Mysql_Table_Account_Log::insertAccountLog($vas[0]['account_id'], $_SESSION['administrator']['id'], '分配需求', '分配需求', $request['demand_id']);

        return Api::request('success', '', '  分配负责人成功');


    }
}