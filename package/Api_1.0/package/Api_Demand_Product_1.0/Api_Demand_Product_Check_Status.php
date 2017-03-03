<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:31
 */
class Api_Demand_Product_Check_Status extends Api
{
    static function handle($args = '')
    {
        $result = self::handleCheck($args);
        return $result;
    }


    static function handleCheck($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'string',
        ), $_REQUEST);
        if (empty($request['phone'])) {
            $result = self::request('error', '', "手机号码传递错误！");
            return $result;
        }

        $condition = array();
        $condition['phone = ?'] = $request['phone'];
        $rs_a = Data_Mysql_Table_Space_Item::select('id', $condition);
        $rs_b = Data_Mysql_Table_Space_Assign::select('id', $condition);
        $rs_c = Data_Mysql_Table_New_Space::select('id,status', $condition, '', 50);
        if (empty($rs_a[0]) && empty($rs_b[0]) && empty($rs_c[0])) {
            $data['back_status'] = -1;
            return $result = self::request('success', $data, '该手机号还没有注册为场地管家，可以点击“我有空间场地要出租”申请注册');
        } elseif (!empty($rs_c[0])) {
            $check = $refuse = $pass = $delete = array();
            foreach ($rs_c as $k => $v) {
                if ($v['status'] == 0) {
                    $check[] = $v['id'];
                }
                if ($v['status'] == 1) {
                    $pass[] = $v['id'];
                }
                if ($v['status'] == 2) {
                    $refuse[] = $v['id'];
                }
                if ($v['status'] == -1) {
                    $delete[] = $v['id'];
                }
            }
            $total_num = count($rs_c);
            $check_num = count($check);
            $pass_num = count($pass);
            $refuse_num = count($refuse);
            $delete_num = count($delete);
            if ($total_num == $check_num) {
                $data['back_status'] = 0;
                return $result = self::request('success', $data, '该手机号在场地出租页面提交的场地正等待审核，请等待审核通过！');
            } elseif ($total_num == $refuse_num) {
                $data['back_status'] = 2;
                return $result = self::request('success', $data, '该手机号在场地出租页面提交的场地审核拒绝，请修改后重新提交！');
            } elseif ($pass_num > 0) {
                $data['back_status'] = 1;
                return $result = self::request('success', $data, '该手机号在场地出租页面提交的场地审核已通过！');
            } elseif ($total_num == $delete_num) {
                $data['back_status'] = -2;
                return $result = self::request('success', $data, '该手机号在场地出租页面提交的场地已被删除！');
            } else {
                $data['back_status'] = 3;
                return $result = self::request('success', $data, '该手机号在场地出租页面提交的场地存在多种状态！');
            }
        } else {
            $data['back_status'] = 4;
            return $result = self::request('success', $data, '该手机号已经注册为场地管家，可以管理下属场地');
        }
    }

}