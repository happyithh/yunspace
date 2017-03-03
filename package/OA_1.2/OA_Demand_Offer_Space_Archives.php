<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/1/13
 * Time: 16:26
 * 报价系统
 */
class OA_Demand_Offer_Space_Archives
{

    static function  handle()
    {
        $request = Func_Input::filter(array(
            'action' => 'string'
        ));
        switch ($request['action']) {

            case 'detail':
                break;
            case 'preview':
                self::handlePreview();
                break;
            default:
                self::handleList();

        }

    }

    /**
     *
     */
    static function  handlePreview()
    {
        @session_start();
        $request = Func_Input::filter(array(
            'phone' => 'phone'
        ));

//        $request['phone'] = 13127808798;
        $table = "{table} as t1 LEFT JOIN {prefix}account_wechat_manager as t2 ON t1.id=t2.account_id";
        $rs = Data_Mysql_Table_Account::select('t1.*', array('t1.phone=?' => array($request['phone'])), '', 1, $table);
        if (empty($rs[0])) {
            Func_Header::to('没有找到账户信息~');
        }
        $r = $rs[0];

        $_SESSION['user'] = array(
            'id' => $r['id'],
            'fullname' => $r['fullname'],
            'email' => $r['email'],
            'phone' => $r['phone'],
            'username' => $r['username'],
            'avatar' => $r['avatar'],
            'identity_time' => $r['identity_time'],
            'pnr_account' => $r['pnr_account'],
            'password' => $r['password'],
            'password2' => $r['password2'],
            'attr' => $r['attr'] ? json_decode($r['attr'], 1) : '',
            'register_time' => $r['register_time'],
            'login_time' => time(),
            'sub_account' => false,
            'openid' => @$r['openid'],
            'isWechatManage' => 1,  //微信管家服务号
        );
        $url = "http://" . Core::$urls['host'] . Core::$urls['root'] . 'm/demand_offer.v2/wechatvendor';
        Func_Header::to('', $url);
    }

    /**
     * 列表
     */
    static function handleList()
    {
        $request = Func_Input::filter(array(
            'search' => 'array',
            'type' => 'string',
        ));

        $table = '{table} as tb1 LEFT JOIN {prefix}space_item as tb2 ON tb1.item_id =tb2.id LEFT JOIN
         {prefix}spacepedia as tb3 ON tb2.space_id =tb3.id';
        $order = ' order by tb2.contacts desc ,tb2.expand_status desc';
        $cols = "tb1.id as result_id,tb1.update_time as s_a_update_time,(tb1.notice_last_time- tb1.scheme_last_time) as gap_time,tb1.city as s_a_city,tb1.*,tb2.*,tb3.space_name,tb3.category_id";
        $conditions = array();
        if (!empty($request['search'])) {
            $search = Func_Input::filter(array(
                'city' => 'string',
                'space_name' => 'string',

            ), $request['search']);
            if (!empty($search['city'])) {
                $conditions[] = "tb1.city ='" . $search['city'] . "'";
            }
            if (!empty($search['space_name'])) {
                $conditions[] = "tb2.item_name ='" . $search['space_name'] . "'";
            }
        }
        if (!empty($request['type'])) {
            switch ($request['type']) {
                case 'order_asc':
                    $order = "ORDER BY gap_time ASC";
                    break;
                case 'order_desc':
                    $order = "ORDER BY gap_time DESC";
                    break;
                case 'notice_desc':
                    $order = "ORDER BY tb1.notice_sum DESC";
                    break;
                case 'response_desc':
                    $order = "ORDER BY tb1.response_sum DESC";
                    break;
            }
        } else {
            $request['type'] = 'all';
        }
        Tpl_Smarty::assign('type', $request['type']);
        $list = Data_Mysql_Table_Demand_Match_Space_Archives::page(0, 20, $cols, $conditions, $order, $table);
        $list['rows'] = self::dataFormat($list['rows']);

        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::display("OA_Static::Space_Archives.v1.0/space_archives_list.tpl");

    }


    /**
     * @param $array
     * @return array
     * 格式化数据
     * 统一输出
     */
    static function  dataFormat($array)
    {
        if (!is_array($array)) {
            return false;
        }
        $phones = array();
        $match = array();
        foreach ($array as $key => $val) {
            $array[$key]['notice_last_time'] = empty($val['notice_last_time']) ? '暂无' : Date('Y-m-d H:i:s', $val['notice_last_time']);
            $array[$key]['scheme_last_time'] = empty($val['scheme_last_time']) ? '暂无' : Date('Y-m-d H:i:s', $val['scheme_last_time']);
            $array[$key]['s_a_update_time'] = empty($val['s_a_update_time']) ? '暂无' : Date('Y-m-d H:i:s', $val['s_a_update_time']);
            if ($val['phone']) {
                $phones[] = $val['phone'];
                $match[$val['phone']] = $key;;
            }

        }
        if (!empty($phones)) {
            $table = "{table} as t1 LEFT JOIN {prefix}account_wechat_manager as t2 ON t1.id = t2.account_id LEFT JOIN {prefix}space_item as t3
             ON t1.phone=t3.phone";
            $where[] = "t1.phone IN (" . implode(',', $phones) . ")";
//            Data_Mysql_Table_Account::debug(1);
            $account = Data_Mysql_Table_Account::select('t1.phone,t2.openid', $where, '', count($phones), $table);
            if (!empty($account)) {
                foreach ($account as $k => $val) {
                    if (!empty($val['openid'])) {
                        if (isset($match[$val['phone']])) {
                            $array[$match[$val['phone']]]['openid'] = $val['openid'];
                        }
                    }
                }
            }
        }
        return $array;

    }

} 