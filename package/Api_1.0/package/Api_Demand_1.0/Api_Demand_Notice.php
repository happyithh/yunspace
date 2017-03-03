<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/27
 * Time: 16:15
 * 是否创建群组
 */
class Api_Demand_Notice extends Api
{
    /**
     * param $args = array(
     *          'demand_id'=>''
     *          'email'=>''
     *          'title'=>''
     *
     * )
     *
     *  新需求通知到组长
     */
    static function noticeGroupLeader($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'email' => 'string',
            'title' => 'string',
        ), $args);
        //1. 根据 $demand_id 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $request['demand_id']);
        if (empty($r[0])) {
            return false;
        }

        $title = ' 新的需求通知到您';
        $email = $request['email'];
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand']['联系人']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand']['product_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/service_info/{$demand['demand']['product_id']}.html' target='_blank'>点击访问(新窗口)</a>";
        } elseif (!empty($demand['demand']['set_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/set_info/{$demand['demand']['set_id']}.html' target='_blank'>点击访问(新窗口)</a>";

        } else {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br>\n";
            }
        }
        $msg .= '</dd>';
        $r[0];
        $contact = Data_Mysql_Table_Contact_Library::select('id', array('phone' => $r[0]['phone']));

//        $contact = $r[0];
//        $contact['attr'] = json_decode($contact['attr'], 1);
//        $msg .= "<hr><dt>联系人详情: </dt><dd>";
//        if ($contact['company']) {
//            $msg .= "公司名称:{$contact['company']}<br>\n";
//        }
//        $msg .= "姓名:{$contact['username']}<br>\n";
//        if ($contact['position']) {
//            $msg .= "职位:{$contact['position']}<br>\n";
//        }
//        if (!empty($contact['attr'])) {
//            foreach ($contact['attr'] as $k => $v) {
//                if (is_array($v)) {
//
//                    foreach ($v as $vk => $vv) {
//                        if ($vv) {
//                            $msg .= "{$vk}:{$vv}<br>\n";
//                        }
//                    }
//                } else {
//                    $msg .= "{$k}:{$v}<br>\n";
//                }
//            }
//        }
//        $msg .= '</dd>';
        //3.0 查询近期联系记录
        $msg .= "<hr><dt>近期联系记录: </dt><dd>";
        $rs = Data_Mysql_Table_Contact_Record::select('content, `time`', array('contact_id' => $contact[0]['id']), 'ORDER BY id DESC', 10);
        if (!empty($rs)) {
            $msg .= '<ul>';
            foreach ($rs as $v) {
                $msg .= "<li>" . date('Y-m-d', $v['time']) . " > {$v['content']}</li>";
            }
            $msg .= '</ul></dd>';
        } else {
            $msg .= '暂无</dd>';
        }
        return Func_Mail::send($email, $title, $msg . '</dl>');

    }

    /**
     *param $args =>array(
     *           'demand_id' => 'int',
     *          'email' => 'int',
     *          'account_id' => 'int',
     * );
     * 通知到负责人
     */
    static function  noticeSalePersonnel($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'email' => 'string',
            'account_id' => 'int',
            'notice_type' => 'int',
        ), $args);
        if(empty($request['demand_id'])){
            return false;
        }
        //1. 根据 $demandId 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $request['demand_id']);
        if (empty($r[0])) {
            return false;
        }
        $title = ' 新的需求分配到您';
        $email = $request['email'];
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        if (!empty($request['notice_type']) && $request['notice_type'] == 1) {
            $title = "【加急】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        } else {
            $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";

        }
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand']['联系人']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand']['product_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/service_info/{$demand['demand']['product_id']}.html' target='_blank'>点击访问(新窗口)</a>";
        } elseif (!empty($demand['demand']['set_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/set_info/{$demand['demand']['set_id']}.html' target='_blank'>点击访问(新窗口)</a>";

        } else {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br/>\n";
            }
        }
        $msg .= '</dd><br/>';
        //免登陆发消息
       /* $loginUrl = Api_Get_Login_DWZ::getLoginLink(array(
            'account_id' => $request['account_id'],
            'access_url' => "http://" . Core::$urls['host'] . '/m/chat/?index=2&url=chat_demand_recommend?demand_id=' . $demand['id'],
            'overdue_time' => '60',
        ));
        if (!empty($loginUrl['data'])) {
            $msg .= '<a href="' . $loginUrl['data'] . '" target="_blank">点击前往管理活动需求>></a>';
        }*/

        Func_Mail::send($email, $title, $msg . '</dl>');

    }

    /**
     *
     *@通知客服
     * @$args =>array(
     *          'demand_id'=>''
     *
     *
     * )
     */
    static function  noticeCustomerService($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $args);
        //1. 根据 $demandId 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $request['demand_id']);
        if (empty($r[0])) {
            return false;
        }
        $title = ' 有新需求';
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand']['联系人']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand']['product_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/service_info/{$demand['demand']['product_id']}.html' target='_blank'>点击访问(新窗口)</a>";
        } elseif (!empty($demand['demand']['set_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/set_info/{$demand['demand']['set_id']}.html' target='_blank'>点击访问(新窗口)</a>";

        } else {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br/>\n";
            }
        }
        $msg .= '</dd><br/>';
        $email = Data_Config_Demand_Notice::get('客服部');

        Func_Mail::send($email, $title, $msg . '</dl>');
    }


    /**
     * 通知负责人 V2 . 11/24 可以输入联系记录
     * TODO::
     */


}
