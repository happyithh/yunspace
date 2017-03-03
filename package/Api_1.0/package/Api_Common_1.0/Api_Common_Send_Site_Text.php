<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();

class Api_Common_Send_Site_Text extends Api
{
    //发送验证码
    static function handle()
    {
        /**
         *微信公众号通知
         *
         *
         *
         *
         */

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        /*  $result = self::SendWinInform($_REQUEST);
          return $result;*/
    }

    //返回参数
    /*  static function sendSiteText($args)
      {
          $request = Func_Input::filter(array(
              'phone' => 'phone',
              "messge" => "string",  //不同地方的验证码  注册。登录。找回密码等
          ), $args);
          if (!$request['phone']) {
  //            die('参数错误!');
              $result = self::request('error', '', "手机号不能为空！");
              return $result;
          }
          $smsTpl = 14467;
          if (!Func_Input::isLocal()) {
              Func_Message::sendSMS($request['phone'], array(
                  $request['messge'],
              ), $smsTpl);
          }
              return Api::request('success', '', "验证码发送成功！");
      }*/
    static function SendWinInform($args)
    {
        $request = Func_Input::filter(array(
            'openid' => 'string',
            "space_name" => "string",
            "create_time" => "int",
        ), $args);
        if (empty($request['openid']) || empty($request['space_name']) || empty($request['create_time'])) {
            return Api::request('error', '', '参数缺失！');

        }
        $send = array(
            "touser" => $request['openid'],
            "template_id" => "GPGqudFc-FnrtKQHFXfBtl4HtYVzrAz2PIhYG-NTpKY",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "您在云space提交的场地信息已经审核通过啦",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => $request['space_name'],
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => date("Y-m-d H:i:s",$request['create_time']),
                    'color' => '#173177'
                ),

                "remark" => array(
                    "value" => "如有疑问请咨询400-056-0599",
                    "color" => "#173177",
                )
            )
        );
        return   Wechat_Messag_Push::ManagerPush($send);

    }

    static function SendWinReason($args)
    {

        $request = Func_Input::filter(array(
            'openid' => 'string',
            "space_name" => "string",
            "refuse_reason" => "string",
        ), $args);

        if (empty($request['openid']) || empty($request['space_name']) || empty($request['refuse_reason'])) {
            return Api::request('error', '', '参数缺失！');
        }
        $send = array(
            "touser" => $request['openid'],
            "template_id" => "kWFlqWoWrAFytC8SgX0LpFy76krpk_shrOpWTQs9fzM",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "您在云space提交的场地信息审核被拒绝",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => $request['space_name'],
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => $request['refuse_reason'],
                    'color' => '#173177'
                ),

                "remark" => array(
                    "value" => "如有疑问请咨询400-056-0599",
                    "color" => "#173177",
                )
            )
        );
        return Wechat_Messag_Push::ManagerPush($send);

    }
}

