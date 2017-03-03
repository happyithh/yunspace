<?php

/**
 * 接口
 * 获取联系人列表
 */
class Api_Livechat_Contacts_List extends Api
{
    /**
     * @param string $args
     *       {
     *       * account_id:  [handle: Api_Session::user_id()] ,
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
        return self::getList($args);

    }

    /**
     *
     */
    static function getList($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
        ), $args);
        if (empty($request['account_id'])) {
            return Api::request('error', '', '请先登录');
        }
        $cols = 'contact_account_id,contact_name,config,update_time,initials';
        $conditions['account_id =? AND status >=?'] = array($request['account_id'], 0);

        $data = Data_Mysql_Table_LiveChat_Contacts::select($cols, $conditions, ' ORDER BY initials ASC', 100);
        if (empty($data[0])) {
            return Api::request('error', '', '您还没有联系人');
        }
        $letter = array();
        foreach ($data as $k => $v) {
            $letter[] = $v['initials'];
        }
        $letter = array_unique($letter);
        sort($letter);
        $list['datas'] = $data;
        $list['letter'] = $letter;
        return Api::request('success', $list, '获取成功');


    }


}

