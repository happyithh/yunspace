<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/30
 * Time: 15:17
 */
class  Data_Config_Message_Template extends Data_Config
{
    /**
     * @var array
     *  1 回复客户
     *
     */
    public $all = array(
        1 => array(
            "touser" => 'openid',
            "template_id" => "lTFV2jkPpY1VChR3m2NKtQ51_KWrOt4PUSqc2kv6lCo",
            "url" => 'www.yunspace.com.cn',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "新需求通知--您好，新的咨询请尽快回复！",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "点击进入咨询页面",
                    "color" => "#173177",
                )
            )
        ),
        2 => array(
            "touser" => 'openid',
            "template_id" => "lTFV2jkPpY1VChR3m2NKtQ51_KWrOt4PUSqc2kv6lCo",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "您好，您咨询商家的问题已回复",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "点击进入咨询页面",
                    "color" => "#173177",
                )
            )
        ),
        3 => array(
            "touser" => 'openid',
            "template_id" => "lTFV2jkPpY1VChR3m2NKtQ51_KWrOt4PUSqc2kv6lCo",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "服务推荐通知---您好，您有一条新的服务推荐！",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "点击进入页面",
                    "color" => "#173177",
                )
            )
        ),
        4 => array(
            "touser" => 'openid',
            "template_id" => "lTFV2jkPpY1VChR3m2NKtQ51_KWrOt4PUSqc2kv6lCo",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "带看场地通知--您好，您有一条新的带看场地！",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "点击进入页面",
                    "color" => "#173177",
                )
            )
        ),
        5 => array(
            "touser" => 'openid',
            "template_id" => "bn1zEX0qfXy-rsnMT1mYLBUZO9Qd6a8ATYKz-cUpzpw",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "未读消息提醒",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '【云·Space消息系统】',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请点击详情进入【云·Space】最新消息列表查看",
                    "color" => "#173177",
                )
            )
        ),

    );
    //TODO::
    static  $saleWechat = array(
        'new_order' => array(
            "touser" => 'openid',
            "template_id" => "bn1zEX0qfXy-rsnMT1mYLBUZO9Qd6a8ATYKz-cUpzpw",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "未读消息提醒",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '【云·Space消息系统】',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请点击详情进入【云·Space】最新消息列表查看",
                    "color" => "#173177",
                )
            )
        ),
        //给组长分配用
        'new_order_allot' => array(),

    );


}
//"first" => array(
//    "value" => urlencode("您好，您咨询商家的问题已回复"),
//    "color" => "#173177",
//),
//                "keyword1" => array(
//    "value" => urlencode('5'),
//    "color" => "#173177",
//),
//                "keyword2" => array(
//    "value" => urlencode('4564'),
//    "color" => "#173177",
//),
//                "remark" => array(
//    "value" => urlencode("点击进入咨询页面"),
//    "color" => "#173177",
//),