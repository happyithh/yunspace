<?php

/**
 *
 * 删除一个联系人
 *
 */
class Api_Livechat_Contacts_Remove extends Api
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
        return self::handleRemoveContact($args);

    }

    /**
     *
     */
    static function handleRemoveContact($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'contact_account_id' => 'int',
        ), $args);
        if (empty($request['contact_account_id']) || empty($request['account_id'])) {

            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数的合法性');
        }
        $status = Data_Mysql_Table_LiveChat_Contacts::update(array(
            'account_id=?' => $request['account_id'],
            'contact_account_id=?' => $request['contact_account_id'],
        ),
            array('status'=> '-1'));
        if (empty($status[0])) {
            return Api::request('error', '', '移除联系人失败');
        }
        return Api::request('success', '', '成功移除该联系人');

    }


}

