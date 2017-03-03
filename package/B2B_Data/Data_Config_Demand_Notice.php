<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/5/5
 * Time: 15:56
 *
 */
class Data_Config_Demand_Notice extends Data_Config
{
    public $all = array(
        '默认' => '18018630471',
        '测试' => '13761718098',
        '办活动' => '18018630471',
        '整体方案' => '18018630471',
        '订单转发' => '18018630471',
        '供应商加盟' => '18018630471',
        '实地看场' => '18018630471',
        '预约咨询' => '18018630471',
        '客户人工服务' => '18018630471',
        '供应商人工客服' => '18018630471',
        '客服部' => 'roy.cheng@yunspace.com.cn',
        '销售部' => 'kim@yunspace.com.cn',
        '市场部' => 'gary@yunspace.com.cn;edward@yunspace.com.cn;jayson@yunspace.com.cn',
        '销售部KA客户通知' => 'apple.cheng@yunspace.com.cn',
        '销售部标准客户通知' => 'kim@yunspace.com.cn',
        '邮件地址' => 'roy.cheng@yunspace.com.cn',
        '财务部' => 'ye.zhang@yunspace.com.cn;summer@yunspace.com.cn;gil@yunspace.com.cn',
        '运营部' =>'Bruce@yunspace.com.cn',
        '场地出租审核人' =>'Nicky@yunspace.com.cn',
    );

    /**
     * @param $demandId
     * @param string $title
     * @param string $msg
     *
     * 触发条件:
     * 1 新需求提交时
     * 2 需求转联系人时
     * 3 分配负责人时
     */
    static function sendNotice($demandId, $title = '', $msg = '')
    {
        //1. 根据 $demandId 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $demandId);
        if (empty($r[0])) {
            return false;
        }
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand_name']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand']['product_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/service_info/{$demand['demand']['product_id']}.html' target='_blank'>点击访问(新窗口)</a>";
        } else {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br>\n";
            }
        }
        $msg .= '</dd>';

        //2. 查询联系人, 如果没有联系人, 则通知到运营主管.
        $r = Data_Mysql_Table_Contact_Library::select('*', array('(phone=?)' => array($demand['phone'])));
        if (empty($r[0])) {
            //2.1 查询联系人, 如果没有联系人, 则通知到客服主管.
            $email = self::get('客服部');
            Func_Mail::send($email, $title, $msg . '</dl>');
            return 1;
        }
        $contact = $r[0];
        $contact['attr'] = json_decode($contact['attr'], 1);
        $msg .= "<hr><dt>联系人详情: </dt><dd>";
        if ($contact['company']) {
            $msg .= "公司名称:{$contact['company']}<br>\n";
        }
        $msg .= "姓名:{$contact['username']}<br>\n";
        if ($contact['position']) {
            $msg .= "职位:{$contact['position']}<br>\n";
        }
        if (!empty($contact['attr'])) {
            foreach ($contact['attr'] as $k => $v) {
                if (is_array($v)) {

                    foreach ($v as $vk => $vv) {
                        if ($vv) {
                            $msg .= "{$vk}:{$vv}<br>\n";
                        }
                    }
                } else {
                    $msg .= "{$k}:{$v}<br>\n";
                }
            }
        }
        $msg .= '</dd>';
        //3.0 查询近期联系记录
        $msg .= "<hr><dt>近期联系记录: </dt><dd>";
        $rs = Data_Mysql_Table_Contact_Record::select('content, `time`', array('contact_id' => $contact['id']), 'ORDER BY id DESC', 10);
        if (!empty($rs)) {
            $msg .= '<ul>';
            foreach ($rs as $v) {
                $msg .= "<li>" . date('Y-m-d', $v['time']) . " > {$v['content']}</li>";
            }
            $msg .= '</ul></dd>';
        } else {
            $msg .= '暂无</dd>';
        }

        //3. 查询联系人负责人, 如果没有联系人负责人, 则通知到销售/市场主管. 销售还分 ka 和 标准
//        Data_Mysql_Table_Contact_Relation::debug(1);
        $r = Data_Mysql_Table_Contact_Relation::select('t2.id, t2.email', array('contact_id' => $contact['id'], 't3.city=?' => $demand['city']), '', 1, '{table} LEFT JOIN {prefix}administrator AS t2 ON {table}.admin_id = t2.id LEFT JOIN {prefix}department_member AS t3 ON t3.admin_id = t2.id AND t3.department_name="销售部"');
        if (empty($r[0]['email'])) {
            //3.1 查询联系人负责人, 如果没有联系人负责人, 则通知到销售/市场主管. 销售还分 ka 和 标准
            if ($demand['demand_type'] == '供应商加盟') {
                $email = self::get('市场部');
            } else {
                //ka
                $email = self::get($contact['customer_type'] == 1 ? '销售部KA客户通知' : '销售部标准客户通知');
            }
            Func_Mail::send($email, $title, $msg . '</dl>');
            return 2;
        } else {
            //3.2 通知到 联系人负责人
            Func_Mail::send($r[0]['email'], $title, $msg . '</dl>');
            return 3;
        }
    }

    /**
     *@新需求通知到组长
     */
    static function newDemandNotice($demandId, $email, $title = '新需求', $msg = '')
    {
        //1. 根据 $demandId 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $demandId);
        if (empty($r[0])) {
            return false;
        }
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

        //2. 查询联系人, 如果没有联系人, 则通知到运营主管.
        $r = Data_Mysql_Table_Contact_Library::select('*', array('(phone=?)' => array($demand['phone'])));
        if (empty($r[0])) {
            //2.1 查询联系人, 如果没有联系人, 则通知到客服主管.
            $email = self::get('客服部');
            Func_Mail::send($email, $title, $msg . '</dl>');
            return 1;
        }
        $contact = $r[0];
        $contact['attr'] = json_decode($contact['attr'], 1);
        $msg .= "<hr><dt>联系人详情: </dt><dd>";
        if ($contact['company']) {
            $msg .= "公司名称:{$contact['company']}<br>\n";
        }
        $msg .= "姓名:{$contact['username']}<br>\n";
        if ($contact['position']) {
            $msg .= "职位:{$contact['position']}<br>\n";
        }
        if (!empty($contact['attr'])) {
            foreach ($contact['attr'] as $k => $v) {
                if (is_array($v)) {

                    foreach ($v as $vk => $vv) {
                        if ($vv) {
                            $msg .= "{$vk}:{$vv}<br>\n";
                        }
                    }
                } else {
                    $msg .= "{$k}:{$v}<br>\n";
                }
            }
        }
        $msg .= '</dd>';
        //3.0 查询近期联系记录
        $msg .= "<hr><dt>近期联系记录: </dt><dd>";
        $rs = Data_Mysql_Table_Contact_Record::select('content, `time`', array('contact_id' => $contact['id']), 'ORDER BY id DESC', 10);
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

}