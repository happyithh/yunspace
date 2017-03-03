<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @获取群组列表
 */
class  Api_Livechat_Group_List extends Api
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
        //20150720
        $request = Func_Input::filter(array(
            'account_id' => 'int',       //要判断的成员
        ), $args);
        if (empty($request['account_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $conditions['members'][$request['account_id']] = array('account_id' => $request['account_id']);
        $group = Data_Mysql_Table_LiveChat_Group::select('id,name,members,demand_id', $conditions, '', 200);
        if (empty($group)) {
            return false;
        } else {
            foreach ($group as $k => $v) {
                $group[$k]['group_id'] = Data_Mysql_Table_LiveChat_Group::convertToAccountId($v['id']);
                $group[$k]['members'] = json_decode($v['members'], 1);
            }
            return Api::request("success", $group, "获取成功");
        }
    }

}