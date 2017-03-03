<?php

/**
 * 接口
 * 添加一个联系人
 */
class Api_Livechat_Contacts_Add extends Api
{
    /**
     * @param string $args
     *       {
     *       * account_id:  [handle: Api_Session::user_id()] ,
     *       * contact_account_id:  ,
     *       }
     * @return array
     *      {
     *
     *      }
     */
    static function handle($args = '')
    {
        Api_Session::checkToken();
        $args['account_id'] = Api_Session::user_id();
        return self::addContact($args);

    }

    /**
     *
     */
    static function addContact($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'contact_account_id' => 'int',
            'contact_name' => 'string',
        ), $args);

        if (empty($request['account_id']) || empty($request['contact_account_id'])) {
            return false;
        }

        if (empty($request['contact_name'])) {
            $request['contact_name'] = Api_Account_GetBaseInfo::getSystemNameById($request['contact_account_id']);
        }
        $r = Data_Mysql_Table_LiveChat_Contacts::update(array(
            'account_id' => $request['account_id'],
            'contact_account_id' => $request['contact_account_id'],
            'contact_name' => $request['contact_name'],
            'status' => 0,
            'initials' => $request['contact_name'] ? Func_String::getFirstCharter($request['contact_name']) : '',
        ));
        //如果添加成功 且没有提交联系人名时, 则更新联系人名称、首字母
        if (!empty($r[0]) && !$request['contact_name']) {
            $accountInfo = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $request['contact_account_id']));
            $accountInfo['fullname'] = empty($accountInfo['fullname']) ? $accountInfo['username'] : $accountInfo['fullname'];
            $accountInfo['initials'] = Func_String::getFirstCharter($accountInfo['fullname']);
            Data_Mysql_Table_LiveChat_Contacts::update($r[0], array(
                'contact_name' => $accountInfo['fullname'], //备注名称
                'initials' => Func_String::getFirstCharter($accountInfo['fullname']),  //联系人首字母
            ));
        }
        return self::request('success', $request, "添加成功");
    }


}

