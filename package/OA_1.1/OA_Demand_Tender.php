<?php

/**报价列表
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/8
 * Time: 13:49
 */
@session_start();

class  OA_Demand_Tender
{
    static function   handle()
    {
        if (isset($_REQUEST['act']) && $_REQUEST['act'] == 'demand_offer') {
            OA_Demand_Offer::handle();
        } else {
            $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
            switch ($action) {
                case 'list':
                    self::handleDemandTenderList();
                    break;
                case 'detail':
                    self::handleDemandTenderDetail();
                    break;
                case 'is_my':
                    self::handleDemandTenderList();
                    break;
            }
        }

    }


    static function  handleDemandTenderList()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'admin_id' => 'int',
        ));
        $type = empty($request['type']) ? 'done' : $request['type'];
        switch ($type) {
            case 'all':
                $conditions[] = '';
                break;
            case 'done':
                $conditions ['(t1.status =? OR t1.status =? OR t1.status =? OR t1.status =?)'] = array(0, 1, 2, 3);
                break;
            case 'end':
                $conditions['t1.status=?'] = 4;
                break;
            case 'abandon':
                $conditions['t1.status <?'] = 0;
                break;
        }
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'city' => 'string',
                'phone' => 'string',
                'no' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['admin_id'])) {
                $conditions["t2.admin_id =?"] = $search['admin_id'];
            }
            if (!empty($search['city'])) {
                $conditions['t2.city =?'] = $search['city'];
            }
            if (!empty($search['phone'])) {
                $conditions['t2.phone =?'] = $search['phone'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['t1.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['t1.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['t1.create_time < ?'] = strtotime($search['end_time']);
            }
            if (!empty($search['no'])) {
                $conditions['(t1.demand_id =? OR t1.demand_id=?)'] = array($search['no'], Func_NumEncode::d($search['no']));
            }
        }
        if (!empty($request['admin_id'])) {
            $conditions["t1.admin_id =?"] = $request['admin_id'];
        }
        $conditions_count = array();
        if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'is_my' && isset($_SESSION['administrator']['id'])) {
            $conditions["t1.admin_id =?"] = $_SESSION['administrator']['id'];
            $conditions_count["admin_id =?"] = $_SESSION['administrator']['id'];
            Tpl_Smarty::assign('_is_my', 1);
        }
        $totalNum = array(
            '0' => 0,
            '1' => 0,
            '2' => 0,
            '3' => 0,
            '4' => 0,
            '-1' => 0,
//            '98' => 0,
//            '99' => 0,
        );
        $count = Data_Mysql_Table_Demand_Offer::select('COUNT(*) as c,status', $conditions_count, ' GROUP BY status ', 10);
        foreach ($count as $v) {
            $totalNum[$v['status']] = $v['c'];
//            if($v['status']==0||$v['status']==1||$v['status']==2||$v['status']==3){
//                $totalNum[98]  += $v['c'];
//            }
//            $totalNum[99] += $v['c'];
        }
        Tpl_Smarty::assign('total', array(
            'all' => array_sum($totalNum),
            'done' => $totalNum[0] + $totalNum[1] + $totalNum[2] + $totalNum[3],
            'end' => $totalNum[4],
            'abandon' => $totalNum['-1'],
        ));
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id =t2.id LEFT JOIN {prefix}administrator AS t3 ON t1.admin_id=t3.id";
//        Data_Mysql_Table_Demand_Offer::debug(1);
        $page = Data_Mysql_Table_Demand_Offer::page(0, 0, 't1.*,t2.demand,t2.city,t2.demand_name,t2.phone,t2.mark,t2.mark_tags,t3.fullname,t3.username', $conditions, 'ORDER BY t1.create_time DESC', $table);
        if ($page['rows']) {
            foreach ($page['rows'] as $key => $val) {
                $page['rows'][$key]['mark_tags'] = Data_Mysql_Table_Demand::handleConvertMarkTags(array('mark_tags' => $val['mark_tags']));
            }
        }
        Tpl_Smarty::assign('_session', $_SESSION);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_data', $page);
        Tpl_Smarty::display("OA_Static::demands_tender/demand_tender_list.tpl");
    }


    static function  handleDemandTenderDetail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        $conditions['t1 . id = ?'] = $request['id'];
        $table = "{table} as t1 LEFT JOIN {prefix}demand_tender_matching_product as t2 ON t1.id =t2.tender_id LEFT JOIN {prefix}demand as t4 ON t1.demand_id =t4.id";
        $page = Data_Mysql_Table_Demand_Tender::select('t1 .*,t2 . vendor_ids,t2 . product_ids,t2 . phones,t2 . send_total_num,t2 . product_ids,t2 . vendor_ids,t4 . demand_name,t4 . city,t4 . phone', $conditions, '', 1, $table);

        Tpl_Smarty::assign('data', $page[0]);

        $product_ids = json_decode($page[0]['product_ids']);
        if (!empty($product_ids)) {
            foreach ($product_ids as $k => $v) {
                if (!empty($v)) {


                    foreach ($v as $key => $val) {
                        $ids[] = $val;
                    }
                    // $id[] = $v;


                }
            }
            $product_all = Data_Mysql_Table_Product_Search::page(0, 5, ' * ', array('id IN(' . implode(', ', $ids) . ')'), '', '{
        table}');
            // q($product_all['page']);
            Tpl_Smarty::assign('product_all', $product_all);
            Tpl_Smarty::assign('product_ids', $product_ids);
        }
        $tender = Data_Mysql_Table_Demand_Tender_Scheme::select(' * ', array('tender_id =?' => $request['id']), '', 999);
        if (!empty($tender)) {
            foreach ($tender as $key => $val) {
                $product_id[] = $val['product_id'];
                $tender[$key]['scheme'] = json_decode($val['scheme'], 1);
            }
            $product = Data_Mysql_Table_Product_Search::select('id,product_name,addr', array('id IN(' . implode(', ', $product_id) . ')'));
            Tpl_Smarty::assign('product', $product);
        }
        Tpl_Smarty::assign('_data', $tender);
        Tpl_Smarty::assign('status', Data_Mysql_Table_Demand_Tender::$status);
        Tpl_Smarty::display("OA_Static::demands_tender/demand_tender_detail.tpl");
    }
}