<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/10
 * Time: 9:15
 */
class Api_Winchance_New_Ip_List extends Api
{
    static function ipList()
    {
        $request = Func_Input::filter(array(
            'ip_type' => 'string',
        ), $_REQUEST);
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'category' => 'string',
                'manifestation' => 'string',
                'city' => 'string',
                'cooperating_mode' => 'string',
                'area' => 'string',
                'step' => 'int',
                'ip_name' => 'string',
            ), $_REQUEST['search']);
//            q($request,$_REQUEST);
            if (!empty($search['step'])) {
                $conditions['step =?'] = $search['step'];
            }
            if (!empty($search['admin_id'])) {
                $conditions['admin_id = ?'] = $search['admin_id'];
            }
            if (!empty($search['category'])) {
                $conditions['category = ?'] = $search['category'];
            }
            if (!empty($search['manifestation'])) {
                $conditions['manifestation = ?'] = $search['manifestation'];
            }
            if (!empty($search['city'])) {
                $conditions[] = 'city LIKE "%' . $search['city'] . '%"';
            }
            if (!empty($search['cooperating_mode'])) {
                $conditions[] = 'cooperating_mode LIKE "%' . $search['cooperating_mode'] . '%"';
            }
            if (!empty($search['area'])) {
                if ($search['area'] == '100') {
                    $conditions['min_area <=?'] = 100;
                } elseif ($search['area'] == '3000') {
                    $conditions['max_area >=?'] = 3000;
                } else {
                    $area = explode('-', $search['area']);
                    $conditions['min_area <=?'] = $area[1];
                    $conditions['max_area >=?'] = $area[0];
                }
            }
            if (!empty($search['ip_name'])) {
                if (is_numeric($search['ip_name'])) {
                    $conditions['id = ?'] = $search['ip_name'];
                } else {
                    $conditions[] = 'ip_name LIKE "%'.$search['ip_name'].'%"';
                }
            }
        }

        if (empty($request['ip_type']) || $request['ip_type'] == 'done') {
            $conditions['status =?'] = 1;
        } else {
            $conditions['status=?'] = 0;
        }
//        $conditions['t2.status =?'] = -1;
//        Data_Mysql_Table_Winchance_New::debug(1);
        $data = Data_Mysql_Table_Winchance_New::page(0, 15, '*', $conditions, 'ORDER BY update_time DESC');
        $data_id = array_column($data['rows'], 'id');
        if (!empty($data_id)) {
            $che[] = "ip_id IN (" . implode(',', $data_id) . ")";
            $che['t1.status =?'] = -1;
            /**
             * 审核拒绝数据
             * */
            // 1、主表有数据，某一阶段被拒绝
            $reject_check = Data_Mysql_Table_Winchance_Check::select('t1.*', $che, 'GROUP BY t1.ip_id ORDER BY t1.check_time DESC', 99, '(SELECT * FROM {prefix}winchance_check ORDER BY check_time DESC) AS t1');
            if (!empty($reject_check)) {
                $re_ip_id = array_column($reject_check, 'ip_id');
                $reject_arr = array();
                foreach ($reject_check as $k => $v) {
                    $reject_arr[$v['ip_id']] = $v;
                }
                foreach ($data['rows'] as $k => $v) {
                    if (in_array($v['id'], $re_ip_id)) {
                        if ($v['update_time'] < $reject_arr[$v['id']]['check_time']) {
                            $data['rows'][$k]['reject_reason'] = $reject_arr[$v['id']]['rejectReason'];
                            $data['rows'][$k]['reject_step'] = $reject_arr[$v['id']]['ip_step'];
                            $data['rows'][$k]['reject_time'] = $reject_arr[$v['id']]['check_time'];
                        }
                    }
                }
            }
        }
        // 2、第一次提交就被拒绝/第一次提交未审核的数据/保存草稿箱的数据（主表无数据）只有用户自己可以看到  ------开始-----
        @session_start();
        if (!empty($_SESSION['administrator']['id']) && $request['ip_type'] == 'waiting') {
            $reject['t1.ip_id = ?'] = 0;
            $reject['t1.ip_step = ?'] = 1;
//            $reject['t1.status = ?'] = -1;
            $reject[] = '(t1.status = -1 or t1.status = 0 OR t1.status = 2)';
            $reject['t1.admin_id =?'] = $_SESSION['administrator']['id'];
//            q($reject);
            $step_one_reject = Data_Mysql_Table_Winchance_Check::select('t1.*', $reject, 'ORDER BY t1.check_time DESC', 99, '(SELECT * FROM {prefix}winchance_check ORDER BY check_time DESC) AS t1');
            if (!empty($step_one_reject)) {
                foreach ($step_one_reject as $k => $v) {
                    $reject_check[$k]['data'] = json_decode($v['data'], 1);
                    if($v['status']==-1){
                        $step_one_re[] = array(
                            'reject_reason' => $v['rejectReason'],
                            'reject_step' => $v['ip_step'],
                            'reject_time' => $v['check_time'],
                            'ip_name' => $reject_check[$k]['data']['ip_name'],
                            'create_time' => $v['create_time'],
                            'update_time' => $v['update_time'],
                            'id' => '',
                            'admin_id' => $v['admin_id'],
                            'check_id' => $v['id']
                        );
                    }else{
                        if($v['status']==2){
                            $reject_check[$k]['data']['ip_name'] = $reject_check[$k]['data']['ip_name'].'【草稿箱数据】';
                        }
                        $step_one_re[] = array(
                            'ip_name' => $reject_check[$k]['data']['ip_name'],
                            'create_time' => $v['create_time'],
                            'update_time' => $v['update_time'],
                            'id' => '',
                            'admin_id' => $v['admin_id'],
                            'check_id' => $v['id']
                        );
                    }

                }
//                q($data['rows'],$step_one_re);
                if (isset($step_one_re) && !empty($step_one_re)) {
                    foreach ($step_one_re as $k => $v) {
                        array_unshift($data['rows'], $v);
                    }
                }
            }
        }
        // 第一次提交就被拒绝的数据（主表无数据） ----结束---------------
        return $data;
    }

}