<?php

/**
 * 接口
 * 获取联系人信息
 *
 */
class Api_Livechat_Contacts_GetInfo extends Api
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
        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::handleGetContactInfo($args);

    }

    /**
     *
     */
    static function handleGetContactInfo($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'contact_account_id' => 'int',
        ), $args);
        if (empty($request['account_id']) || empty($request['contact_account_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $conditions['t1.account_id =? AND t1.contact_account_id=?'] = array($request['account_id'], $request['contact_account_id']);
        $table = "{table} as t1 LEFT JOIN {prefix}account as t2 ON t1.contact_account_id = t2.id";
        $cols = 't1.id,t1.contact_account_id,t1.contact_name,t1.config,t1.initials,t2.phone';
        $data = Data_Mysql_Table_LiveChat_Contacts::select($cols, $conditions, '', 1, $table);
        if (empty($data)) {
            return Api::request('error', '', '获取联系人信息失败');
        }

        return Api::request('success', $data[0], '获取成功');
    }


}

