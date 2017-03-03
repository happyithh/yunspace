<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/12
 * Time: 14:47
 * 文创项目---合作咨询
 */
class Api_Demand_WinChance_Create extends Api
{

    static function  handle($args)
    {
        $args['account_id'] = Api_Session::user_id();
        return self::create($args);
    }

    /**
     * @param $args
     * @return int
     */
    static function  create($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'contact_phone' => 'phone',
            'contact' => 'string',
            'content' => 'text',
            'account_id' => 'int'
        ), $args);
        if (empty($request['id']) || empty($request['contact_phone']) || empty($request['content'])) {
            return Api::request('error', '', '请将输入框的内容完善~');
        }
        if (strlen($request['content']) > 600) {
            return Api::request('error', '', '不要超过300字~');
        }
        /**
         * 1.判断这个文创ID是否存在
         * 2.创建一个文创的需求
         * 3 判断需求，不能重复， 一个手机号对于 项目只能提交一次
         *
         */

        $winchance = Data_Mysql_Table_Winchance::select('id,title,status', array('id =?' => $request['id'], 'status=?' => 1));
        if (empty($winchance[0]['id'])) {
            return Api::request('error', '', '该项目已经不存在~，请致电400-056-0599');
        }
        $demand = array(
            '联系人' => $request['contact'],
            '联系电话' => $request['contact_phone'],
            '文创项目名称' => $winchance[0]['title'],
            '咨询内容' => $request['content'],
            '具体要求' => '文创项目名称：'.$winchance[0]['title'].'  咨询内容：'.$request['content']
        );
        $create = array(
            'demand_type' => '文创项目合作',
            'demand' => $demand,
            'phone' => $request['contact_phone'],
            'account_id' => $request['account_id'],
            'demand_name' => $request['contact'] . '-需要文创项目合作',
            'win_id' => $request['id'],
        );
        $demand_data = Api_Demand_Create::create($create);
        if ($demand_data['data'] == 0) {
            return Api::request('error', '', '提交失败~，请致电400-056-0599');
        }
        return Api::request('success', '', '您的合作咨询已经提交~稍后客服会和您联系，请您保持电话畅通~');
    }
}