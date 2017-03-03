<?php

/**
 * Created by PhpStorm.
 * User: zhaozhichao
 * Date: 2015/7/19
 * Time: 15:15
 * @
 * 1.向一个需求推荐服务
 * 2.向这个群发送一个多媒体消息
 */
class  Api_Recommend_Add extends Api
{
    /**
     *
     * 传入参数
     *$args= array(
     *          account_id => [Api_Session::user_id()]
     *          demand_id =>   需求ID
     *          product_id || set_id  =>   产品ID  或者套餐ID
     *          demo      => 推荐理由
     *          step      => 进度
     *          only_add      =>1    只添加记录不发消息
     *
     *返回参数 array(
     * )
     */
    static function  handle($args = '')
    {
        $args['account_id'] = Api_Session::user_id();
        //如果推荐人是 需求的创建者（account_id==recommend_account_id），这条记录的customer_feedback 状态就改为 1；
        if (empty($args['step'])) {
            $is_exist = Data_Mysql_Table_Demand::select('id', array('id=? AND account_id=?' => array($args['demand_id'], $args['account_id'])));
            if (!empty($is_exist[0])) {
                $args['step'] = 1;
            }
        }
        return self::addRecommend($args);

    }

    static function  addRecommend($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'demand_id' => 'int',
            'product_id' => 'int',
            'set_id' => 'int',
            'space_name'=>'string',
            'demo' => 'string',
            'step' => 'int',
            'only_add' => 'int',
        ), $args);
        //1接收推荐的产品ID或者套餐ID
        //2 根据demand_id 想demand_recommend 中中插入数据
        //3 给群发推荐消息
        if ((empty($request['set_id']) && empty($request['product_id'])) && empty($request['account_id']) || empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }

        $insert = array(
            'demand_id' => $request['demand_id'],
            'set_id' => $request['set_id'],
            'product_id' => $request['product_id'],
            'demo' => $request['demo'],
            'recommend_account_id' => $request['account_id'],
            'customer_feedback' => $request['step'],
        );

        $add = Data_Mysql_Table_Demand_Recommend::insert($insert);
        if ($add[0] == 0) {
            return Api::request('error', '', '您推荐的服务提交失败，请稍后再试');
        }

        //如果设置了只发消息，则不发消息
        if (!empty($request['only_add']) && $request['only_add'] == 1) {
            return Api::request('success', '', '  推荐成功');
        }

        //推荐插入成功后向 群发送一条推荐消息
        $group_id = Api_Demand_isGroup::isGroup(array('demand_id' => $request['demand_id']));
        if ($group_id) {
            self::sendMedia(array(
                'product_id' => $request['product_id'],
                'set_id' => $request['set_id'],
                'recommend_account_id' => $request['account_id'],
                'to_account_id' => Data_Mysql_Table_LiveChat_Group::convertToAccountId($group_id)
            ));
        }
        return Api::request('success', '', '  推荐成功');

    }

    static function  sendMedia($request)
    {
        $media = Api_Recommend_MessageMediaFormat::formatSpace($request);

        $sendMessage = array(
            'from_account_id' => $request['recommend_account_id'],
            'to_account_id' => $request['to_account_id'],
            'media' => $media,
        );

        $s1 = Api_Livechat_Message_Send::handleSendMessage($sendMessage);
        if ($s1['status'] == 1) {
            return Api::request('success', '', '  您推荐服务已经发送至群');
        }
        return $s1;
    }


}