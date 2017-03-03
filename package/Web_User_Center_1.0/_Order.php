<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/3
 * Time: 11:18
 */
class Web_User_Center_Order extends Base
{
    static function handle()
    {
        self::handleOrderAllList();
    }

    static
        //订单状态统计
        $counter = array(
        '0' => array(
            '全部',
            0
        ),
        '1' => array(
            '待审核',
            0
        ),
        '2' => array(
            '待签约',
            0
        ),
        '3' => array(
            '待支付',
            0
        ),
//        '4' => array(
//            '待评价',
//            0
//        ),
        '5' => array(
            '已完成',
            0
        ),
        '-10' => array(          //已取消、已拒绝           合并为已取消
            '已取消',
            0
        ),
        '-9' => array(
            '已关闭',
            0
        ),

    );

    //订单列表
    static function handleOrderAllList()
    {
        if (empty($_SESSION['user']['id'])) {
            return false;
        }
        if (Core::$urls['package'] == 'vendor_center/') {
            if (empty($_SESSION['user']['attr']['identity'])) {
//                Func_Header::to('您尚未进行实名认证!', Core::$urls['root'] . 'user_center/user_admin/account_identity');
            }
            $conditions = array(
                'vendor_account_id' => $_SESSION['user']['id'],
            );
            if (!empty($_SESSION['user']['super_vendor'])) {
                $conditions = array(
                    '(vendor_account_id =0 OR vendor_account_id=?)' => $_SESSION['user']['id']
                );
            }
            $conditions['status'] = 1;
        } else {
            $conditions = array(
                'status' => 1,
                'buyer_account_id' => $_SESSION['user']['id'],
            );
        }

        //订单状态统计
        self::handleCounter($conditions);

        //状态筛选
        if (!empty($_REQUEST['status'])) {
            switch ($_REQUEST['status']) {
                case -9:
                    unset($conditions['status']);
                    $conditions['{table}.status != ?'] = 1;
                    break;
                case -10:
                    $conditions[] = "order_status < 0";
                    break;
                case 1:
                    $conditions[] = "order_status < 5 AND order_status >=0";
                    break;
                case 2:
                    $conditions[] = "order_status >4 AND order_status < 12";
                    break;
                case 3:
                    $conditions[] = "order_status > 11 AND order_status < 15";
                    break;
//                case 4:
//                    $conditions[] = "order_status > 14 AND order_status < 90";
//                    break;
                case 5:
                    $conditions[] = "order_status > 14 AND order_status < 100";
                    break;
                case 100:
//                    unset($conditions['status']);
//                    $conditions['order_price != ? AND start_time < ?'] = array(0,time());
                    $conditions['order_price_pay != ?'] = 0;
                    break;
            }
        }

        //如果是搜索
        $request = Func_Input::filter(array(
            'datetime' => 'string',
            'text' => 'string'
        ));
        if (!empty($request['datetime'])) {
            $conditions['create_time>? AND create_time<?'] = array(strtotime($request['datetime']), strtotime($request['datetime'] . ' +1 month'));
        }
        if (!empty($request['text']) && (substr($request['text'], 0, 1) == "A" || substr($request['text'], 0, 1) == "S")) {
            $conditions[] = ' order_no like "' . $request['text'] . '%"';
        } elseif (!empty($request['text'])) {
            $conditions['order_title'] = $request['text'];
            $conditions['vendor_name'] = $request['text'];
        }
        //订单状态
        $cols = array(
            '{table}.*,{prefix}account.username,{prefix}account.fullname'
        );
        $list = Data_Mysql_Table_Order_Info::page(0, 0, $cols, $conditions, 'ORDER BY id DESC', '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id ');
        if (!empty($list['rows'])) {
            $list['rows'] = self::handleOrderList($list['rows']);
        }
        $dates = array();
        $timeNow = time();
        do {
            $dates[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        Tpl_Smarty::assign('dates', $dates);
        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::display('order.tpl');
    }

    static function  handleCounter($conditions)
    {
        $rs = Data_Mysql_Table_Order_Info::select('count(id) as c, order_status', $conditions, 'GROUP BY order_status', 100);
        foreach ($rs as $v) {
            self::$counter[0][1] += $v['c'];
            if ($v['order_status'] < 0) {
                self::$counter[-10][1] += $v['c'];
            } elseif ($v['order_status'] < 5 && $v['order_status'] >= 0) {
                self::$counter[1][1] += $v['c'];
            } elseif ($v['order_status'] > 4 && $v['order_status'] < 12) {
                self::$counter[2][1] += $v['c'];
            } elseif ($v['order_status'] > 11 && $v['order_status'] < 15) {
                self::$counter[3][1] += $v['c'];
//            } elseif ($v['order_status'] > 14 && $v['order_status'] < 90) {
//                self::$counter[4][1] += $v['c'];
            } elseif ($v['order_status'] > 14 && $v['order_status'] < 100) {
                self::$counter[5][1] += $v['c'];
            }
        }
        //获取所有已关闭（status==-9或status==3）的订单
        $con['status != ?'] = 1;

        if (Core::$urls['package'] == 'vendor_center/') {
            $con['vendor_account_id'] = $_SESSION['user']['id'];
            $con_evaluate['vendor_account_id'] = $_SESSION['user']['id'];
            if (!empty($_SESSION['user']['super_vendor'])) {
                $con = array(
                    '(vendor_account_id =0 OR vendor_account_id=?)' => $_SESSION['user']['id']
                );
                $con_evaluate = array(
                    '(vendor_account_id =0 OR vendor_account_id=?)' => $_SESSION['user']['id']
                );
            }
        } else {
            $con['buyer_account_id'] = $_SESSION['user']['id'];
            $con_evaluate['buyer_account_id'] = $_SESSION['user']['id'];

        }

        $close_rs = Data_Mysql_Table_Order_Info::select('count(id) as c', $con);
        if (!empty($close_rs)) {
            self::$counter[-9][1] += $close_rs[0]['c'];
        }

        //获取所有待评价订单
        $con_evaluate['status'] = 1;
        $con_evaluate['order_price_pay != ?'] = 0;
        $evaluate_rs = Data_Mysql_Table_Order_Info::select('count(id) as c', $con_evaluate);
        $evaluate = empty($evaluate_rs[0]['c']) ? 0 : $evaluate_rs[0]['c'];
        Tpl_Smarty::assign('counter', self::$counter);
        Tpl_Smarty::assign('evaluate', $evaluate);
        return self::$counter;
    }

    static function handleOrderList($rows)
    {
        $vendors = array();
        if (!empty($rows)) {
            foreach ($rows as $k => $v) {
                $vendors[] = $v['vendor_id'];
                if (!empty($v['order_price_last'])) {
                    $rows[$k]['order_price'] = $v['order_price_last'];
                }
                if ($v['order_status'] < 0) {
                    $rows[$k]['order_status_text'] = self::$counter[-10][0];
                } elseif ($v['order_status'] < 5) {
                    $rows[$k]['order_status_text'] = self::$counter[1][0];
                } elseif ($v['order_status'] > 4 && $v['order_status'] < 12) {
                    $rows[$k]['order_status_text'] = self::$counter[2][0];
                } elseif ($v['order_status'] > 11 && $v['order_status'] < 15) {
                    $rows[$k]['order_status_text'] = self::$counter[3][0];
//                } elseif ($v['order_status'] > 14 && $v['order_status'] < 90) {
//                    $rows[$k]['order_status_text'] = self::$counter[4][0];
                } elseif ($v['order_status'] > 14 && $v['order_status'] < 100) {
                    $rows[$k]['order_status_text'] = self::$counter[5][0];
                }

                //已删除订单
                if ($v['status'] != 1) {
                    $rows[$k]['order_status_text'] = self::$counter[-9][0];
                }
                if (!empty($v['order_close_info'])) {
                    $rows[$k]['order_close_info'] = json_decode($v['order_close_info'], 1);
                }
            }
            $rs = Data_Mysql_Table_Vendor_Info::select("id, vendor_name", array("id IN (" . implode(',', $vendors) . ")"), '', 100);
            $vendors = array();
            foreach ($rs as $v) {
                $vendors[$v['id']] = $v;
            }
        }
        Tpl_Smarty::assign('vendors', $vendors);
        return $rows;
    }
}
