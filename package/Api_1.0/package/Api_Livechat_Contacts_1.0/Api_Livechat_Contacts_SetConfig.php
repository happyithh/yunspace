<?php

/**
 * 接口
 * 添加一个联系人
 */
class Api_Livechat_Contacts_SetConfig extends Api
{
    /**
     * @param string $args
     *       {
     *       * account_id:  [handle: Api_Session::user_id()] ,
     *       * contact_account_id:  ,
     *         contact_name: '',
     *         config: array,
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
        //TODO:

    }


}

