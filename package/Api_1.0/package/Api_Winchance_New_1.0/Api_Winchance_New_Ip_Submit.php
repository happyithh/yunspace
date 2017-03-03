<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 9:45
 *
 * IP场地提交
 */
@session_start();

class Api_Winchance_New_Ip_Submit extends Api
{
    static function ipSubmit()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'note' => 'string',
            'step' => 'string',
            'submit_type' => 'string',
            'admin_id' => 'int',
            'check_id' => 'int',
            'space_id' => 'int'
        ), $_REQUEST);
        if ($request['step'] != 1 && empty($request['id'])) {
            Func_Header::back('IP的id异常！');
        }
        $data_new = Api_Winchance_New_Ip_Submit_Field_Deal::checkSearchUserField();
        // 操作人处理
        if (isset($_SESSION['administrator']['id']) && !empty($_SESSION['administrator']['id'])) {
            $data_new['operator_id'] = $_SESSION['administrator']['id'];
            $data_new['admin_id'] = empty($request['admin_id']) ? $_SESSION['administrator']['id'] : $request['admin_id'];
        }

        //阶段数据处理
        $data = array();
        if ($request['step'] == 1) {
            $data = Api_Winchance_New_Ip_Submit_Field_Deal::stepOne();
            $data_new['ip_name'] = $data['ip_name'];  // 审核搜索时使用的字段

        } elseif ($request['step'] == 2) {
            $data = Api_Winchance_New_Ip_Submit_Field_Deal::stepTwo();
            $data_new['category'] = $data['category']; // 审核搜索时使用的字段

        } elseif ($request['step'] == 3) {
            $data = Api_Winchance_New_Ip_Submit_Field_Deal::stepThree();
            // 审核搜索时使用的字段
            if (!empty($data['city']) ) {
                $data_new['city'] = $data['city'];
            }
            $data_new['manifestation'] = $data['manifestation'];
            $data_new['min_area'] = $data['min_area'];
            $data_new['max_area'] = $data['max_area'];

        } elseif ($request['step'] == 4) {
            $data = Api_Winchance_New_Ip_Submit_Field_Deal::stepFour();
            // 审核搜索时使用的字段
            if (!empty($data['cooperating_mode'])) {
                $data_new['cooperating_mode'] =  $data['cooperating_mode'];
            }

        } elseif ($request['step'] == 5) {
            $data = Api_Winchance_New_Ip_Submit_Field_Deal::stepFive();
        }

        $data['note'] = $request['note'];
        $data_new['ip_id'] = !empty($request['id'])?$request['id']:0;
        $data_new['data'] = $data;
        $data_new['ip_step'] = $request['step'];
        if ($request['submit_type'] == 'draft') {
            self::insertDraft($data_new);
        } else {
            $data_new['check_id'] = $request['check_id'];
            self::insertCheck($data_new);
        }
    }

    // 保存草稿
    static function insertDraft($data_new)
    {
        if (!empty($data_new['ip_id'])) {
            // 检查是否已存在草稿
            $draft = Data_Mysql_Table_Winchance_Check::select('id', array('ip_id' => $data_new['ip_id'], 'operator_id' => $_SESSION['administrator']['id'], 'ip_step' => $data_new['ip_step'], 'status' => 2));

            if (!empty($draft)) {
                $data_new['update_time'] = time();
                $res = Data_Mysql_Table_Winchance_Check::update(array('ip_id' => $data_new['ip_id'], 'operator_id' => $_SESSION['administrator']['id'], 'ip_step' => $data_new['ip_step'], 'status' => 2), $data_new);
            } else {
                $data_new['create_time'] = time();
                $data_new['status'] = 2;
                $res = Data_Mysql_Table_Winchance_Check::insert($data_new);
            }
        } else {
            // 检查是否已存在草稿  注：如果用户在储备信息阶段且状态为0的情况下，保存草稿箱，意为更新数据
            if (!empty($_REQUEST['check_id'])) {
                $draft = Data_Mysql_Table_Winchance_Check::select('id', array('id' => $_REQUEST['check_id'], 'operator_id' => $_SESSION['administrator']['id'], 'ip_step' => $data_new['ip_step']));
                if (!empty($draft)) {
                    $res = Data_Mysql_Table_Winchance_Check::update(array('id' => $_REQUEST['check_id'], 'operator_id' => $_SESSION['administrator']['id'], 'ip_step' => $data_new['ip_step']), $data_new);
                }
            }else{
                $data_new['status'] = 2;
                $data_new['create_time'] = time();
                $res = Data_Mysql_Table_Winchance_Check::insert($data_new);
            }
        }
        if (!empty($res[0])) {
            Func_Header::to('  操作成功！', '?action=list&ip_type=waiting');
        } else {
            Func_Header::back('操作失败！');
        }

    }

    // 提交审核
    static function insertCheck($data_new)
    {
        if (!empty($data_new['ip_id'])) {
            /**
             * 更新数据
             */

            //检查该IP是否处于审核中的状态
            $check = Data_Mysql_Table_Winchance_Check::select('*', array('ip_id' => $data_new['ip_id'], 'status' => 0));
            if (!empty($check)) {
//            return self::request('error', '', '该IP处于审核状态,不可再提交审核！!');
                Func_Header::back('该IP处于审核状态,不可再提交审核！');
            }

            // 检查是否已存在草稿
            $draft = Data_Mysql_Table_Winchance_Check::select('id', array('ip_id' => $data_new['ip_id'], 'operator_id' => $_SESSION['administrator']['id'], 'ip_step' => $data_new['ip_step'], 'status' => 2));
            // 提交审核
            $data_new['create_time'] = time();
            if (!empty($draft)) {
                $data_new['status'] = 0;
                $res = Data_Mysql_Table_Winchance_Check::update(array('ip_id' => $data_new['ip_id'], 'operator_id' => $_SESSION['administrator']['id'], 'ip_step' => $data_new['ip_step'], 'status' => 2), $data_new);
            } else {
                $res = Data_Mysql_Table_Winchance_Check::insert($data_new);
            }

        } else {
            /**
             *写入数据
             */
            if (!empty($data_new['check_id'])) {
                // 再次编辑第一次提交被拒绝的数据
                $check_id = $data_new['check_id'];
                $data_new['status']=0;
                unset($data_new['check_id']);
                $data_new['update_time'] = time();
//                Data_Mysql_Table_Winchance_Check::debug(1);
                $res = Data_Mysql_Table_Winchance_Check::update(array('id' => $check_id), $data_new);
            } else {
                $data_new['create_time'] = time();
                unset($data_new['check_id']);
                $res = Data_Mysql_Table_Winchance_Check::insert($data_new);
            }
        }

        if (!empty($res[0])) {
            Func_Header::to('  操作成功！', '?action=list&ip_type=waiting');
        } else {
            Func_Header::back('操作失败！');
        }
    }
}