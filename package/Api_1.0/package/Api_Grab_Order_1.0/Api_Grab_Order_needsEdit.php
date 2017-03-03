<?php

/**
 * Created by PhpStorm.
 * User=> zzc
 * Date=> 2015/12/17
 * Time=> 17=>39
 * 销售修改需求
 */
class Api_Grab_Order_needsEdit extends Api
{

    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::edit($args);
    }

    //1.替换联系人信息
    //2.插入报价系统
    static function  edit($args)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'people' => 'string',
            'id' => 'int',
            'price_up' => 'int',
            'price_down' => 'int',
            'start_time' => 'string',
            'end_time' => 'string',
            'city' => 'string',
            'tags' => 'string',
            'mark' => 'string',
        ), $args);
        if (empty($request['mark']) || empty($request['id']) || empty($request['price_down'])) {
            return Api::request('error', '', '参数缺失，请刷新重试。');
        }
        if ($request['price_up'] > $request['price_down']) {
            return Api::request('error', '', '您输入的价格有误，请重新输入');
        }
        $data = Api_Grab_Order_Get_Info::getInfo(array(
            'id' => $request['id'],
            'phone' => $_SESSION['user']['phone'],
        ));
        if (!empty($data['data'])) {
            $demand = $data['data'];

            $newData['demand'] = $demand['demand'];

            $newData['demand']['开始时间'] = $request['start_time'];
            $newData['demand']['结束时间'] = $request['end_time'];
            $newData['demand']['price_up'] = $request['price_up'];
            $newData['demand']['price_down'] = $request['price_down'];
            $newData['demand']['活动标签'] = $request['tags'];
            $newData['demand']['具体要求'] = $request['mark'];
            $newData['price_up'] = $request['price_up'];
            $newData['price_down'] = $request['price_down'];

            //替换信息
            $newData['phone'] = $_SESSION['user']['phone'];
            $newData['account_id'] = $_SESSION['user']['id'];

            if (is_numeric($_SESSION['user']['username'])) {
                $info = Api_Administrator_getBaseInfo::getAdminInfoByPhone(array('phone' => $_SESSION['user']['phone']));
                if (!empty($info['username'])) {
                    Data_Mysql_Table_Account::update(array('id =? AND phone =?' => array($_SESSION['user']['id'], $_SESSION['user']['phone'])),
                        array(
                            'username' => $info['username']
                        ));
                    $_SESSION['user']['username'] = $info['username'];
                }
            }

            $newData['demand']['联系人'] = $_SESSION['user']['username'];
            $newData['demand']['联系电话'] = $_SESSION['user']['phone'];

            $rs = Data_Mysql_Table_Demand::update(array('id=?' => $request['id']), $newData);
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], '', '修改需求', $_SESSION['user']['username'] . '修改需求，并替换了需求的phone,account_id,字段', $request['id']);
            if ($rs[0] > 0) {
                Api_Demand_Offer_Insert::create(array('demand_id' => $request['id']));
                Data_Mysql_Table_Grab_Order::update(array('id' => $request['id']), array('gather_offer_time' => time()));
                //标记销售
                Data_Mysql_Table_Demand::handleAddMarkTags(array(
                    'demand_id'=>$request['id'],
                    'mark_id'=>21,

                ));
                return Api::request('success', '', '成功');
            }
        }
        return Api::request('error', '', '失败，请刷新重试');

    }

} 