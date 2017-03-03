<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/6/30
 * Time: 09:59
 */
class Api_Wechat_Notice_Push extends Api
{
    static function  handle($args = '')
    {
        /**
         *  接受参数
         * 'action' => 'int',  //模板类型
         *        'to_openid' => 'string',  //openid
         *        'title' => 'string',   //标题
         *        'content' => 'string',  //消息内容
         *
         * //返回结果：
         *        发送状态status （0，发送未成功，1发送成功），
         *        状态消息 msg：发 送成功 或发送失败原因
         *        内容data ,'';
         */

        return self::handleType($args);
    }

    static function handleType($args)
    {
        $action = $args['action'];
        $rs = array();
        switch ($action) {
            //咨询-商家有新需求
            case 'new_demand_notice':
                $rs = self::handleNewDemandNotice($args);
                break;
            //咨询-商家回复客户消息啦，
            case 'demand_reply_customer':
                $rs = self::handleDemandReplyCustomer($args);
                break;
            //需求-服务推荐通知，
            case 'recommend_service':
                $rs = self::handleRecommendService($args);
                break;
            //需求-带看场地通知，
            case 'look_space':
                $rs = self::handleLookSpace($args);
                break;
            //新消息通知，
            case 'new_msg':
                $rs = self::handleNewMsg($args);
                break;
        }
        return $rs;
    }

    //咨询-商家有新需求
    static function handleNewDemandNotice($data)
    {
        $request = Func_Input::filter(array(
            'to_openid' => 'string',
            'title' => 'string',
            'content' => 'string',
            'url' => 'string',
        ), $data);
        if (empty($request['to_openid']) || empty($request['title']) || empty($request['content'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $rs = Wechat_Messag_Push::handleAskNotice(1, $request['to_openid'], $request['title'], $request['content'], $request['url']);
        if ($rs['errcode'] == 0) {
            return self::request('success', '', '发送成功！');
        } else {
            return self::request('error', '', '发送失败！');
        }
    }

    //咨询-商家回复客户消息啦
    static function handleDemandReplyCustomer($data)
    {
        $request = Func_Input::filter(array(
            'to_openid' => 'string',
            'title' => 'string',
            'content' => 'string',
            'url' => 'string',
        ), $data);
        if (empty($request['to_openid']) || empty($request['title']) || empty($request['content'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $rs = Wechat_Messag_Push::handleAskNotice(2, $request['to_openid'], $request['title'], $request['content'], $request['url']);
        if ($rs['errcode'] == 0) {
            return self::request('success', '', '发送成功！');
        } else {
            return self::request('error', '', '发送失败！');
        }
    }

    //需求-服务推荐通知
    static function handleRecommendService($data)
    {
        $request = Func_Input::filter(array(
            'to_openid' => 'string',
            'title' => 'string',
            'content' => 'string',
            'url' => 'string',
        ), $data);
        if (empty($request['to_openid']) || empty($request['title']) || empty($request['content'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $rs = Wechat_Messag_Push::handleAskNotice(3, $request['to_openid'], $request['title'], $request['content'], $request['url']);
        if ($rs['errcode'] == 0) {
            return self::request('success', '', '发送成功！');
        } else {
            return self::request('error', '', '发送失败！');
        }
    }

    //需求-带看场地通知
    static function handleLookSpace($data)
    {
        $request = Func_Input::filter(array(
            'to_openid' => 'string',
            'title' => 'string',
            'content' => 'string',
            'url' => 'string',
        ), $data);
        if (empty($request['to_openid']) || empty($request['title']) || empty($request['content'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $rs = Wechat_Messag_Push::handleAskNotice(4, $request['to_openid'], $request['title'], $request['content'], $request['url']);
        if ($rs['errcode'] == 0) {
            return self::request('success', '', '发送成功！');
        } else {
            return self::request('error', '', '发送失败！');
        }
    }

    //消息--新消息通知
    static function handleNewMsg($data)
    {
        $request = Func_Input::filter(array(
            'to_openid' => 'string',
            'title' => 'string',
            'content' => 'string',
            'url' => 'url',
        ), $data);
        if (empty($request['to_openid']) || empty($request['content'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $data = array(
            "touser" => $request['to_openid'],
            "template_id" => "bn1zEX0qfXy-rsnMT1mYLBUZO9Qd6a8ATYKz-cUpzpw",
            "url" => $request['url'] ? $request['url'] : "http://" . Core::$urls['host'] . '/m/chat/?index=0',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => $request['content'],
                    "color" => "#173177",
                ),
                "keynote1" => array(
                    "value" => '【云·Space消息系统】',
                    'color' => '#173177'
                ),
                "keynote2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请点击进入消息列表查看",
                    "color" => "#173177",
                )
            )
        );
        $data['data']['keynote2']['value'] = date('Y-m-d H:i:s');
        $rs = Wechat_Messag_Push::push($data);
        if ($rs['errcode'] == 0) {
            return self::request('success', '', '发送成功！');
        } else {
            return self::request('error', '', '发送失败！');
        }
    }
}