<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/10
 * Time: 9:28
 * 审核提交
 */
@session_start();

class Api_Winchance_New_Ip_Check_Submit extends Api
{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        } else {
            // 主要用于审核拒绝
            return self::rejectSubmit();
        }
    }

    // 审核提交处理
    static function checkSubmit()
    {
        $data = self::fieldDeal();

        $request = Func_Input::filter(array(
            'ip_id' => 'int',
            'id' => 'int',
            'step' => 'int',
            'space_id' => 'int',
        ), $_REQUEST);
        @session_start();
        $data['operator_id'] = empty($_SESSION['administrator']['id']) ? '0' : $_SESSION['administrator']['id'];
        if (!empty($request['ip_id'])) {
            $data['update_time'] = time();
            //修改space_id修改上线状态 只有审核通过才让他上线
            if(!empty($request['space_id'])&&$request['step']==2){
                //修改名称和状态
                $space_data = array(
                    'space_name'=>$data['active_name'],
                    'status'=>$data['online_status']
                );
                Data_Mysql_Table_Spacepedia::update(array('id=?'=>$request['space_id']),$space_data);
            }else{
                //添加场地 返回space_id
                $space_data = array(
                    'space_name'=>$data['active_name'],
                    'status'=>$data['online_status'],
                    'category_id'=>200
                );
               $result= Data_Mysql_Table_Spacepedia::update($space_data);
                if($result){
                    $space_id = $result[0];
                    $data['space_id']=$space_id;
                    $check_da['space_id']=$space_id;
                }else{
                    Func_Header::back('添加文创百科关联出错！58');
                }

            }
            $res = Data_Mysql_Table_Winchance_New::update(array('id' => $request['ip_id']), $data);
        } else {
            $data['create_time'] = time();
            $res = Data_Mysql_Table_Winchance_New::insert($data);
        }
        if (!empty($res[0])) {
            $check_da['status'] = 1;
            $check_da['check_time'] = time();
            if (empty($request['ip_id'])) {
                $check_da['ip_id'] = $res[0];
            }
            Data_Mysql_Table_Winchance_Check::update(array('id=?' => $request['id']), $check_da);
            Func_Header::to('  操作成功！', '?action=list');
        } else {
            Func_Header::back('操作失败');
        }
    }


    // 审核字段处理
    static function fieldDeal()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            // 整体同步存在的字段
            'note' => 'string',
            'step' => 'string',
            'admin_id' => 'int',
            'ip_id' => 'int',

        ), $_REQUEST);
        $data = array();
        if ($request['step'] >= 1) {
            $data = Api_Winchance_New_Ip_Submit_Field_Deal::stepOne();
        }
        if ($request['step'] >= 2) {
            $dataTwo = Api_Winchance_New_Ip_Submit_Field_Deal::stepTwo();
            $data = array_merge($data, $dataTwo);
        }
        if ($request['step'] >= 3) {
            $dataThree = Api_Winchance_New_Ip_Submit_Field_Deal::stepThree();
            $data = array_merge($data, $dataThree);
        }
        if ($request['step'] >= 4) {
            $dataFour = Api_Winchance_New_Ip_Submit_Field_Deal::stepFour();
            $data = array_merge($data, $dataFour);
        }
        if ($request['step'] >= 5) {
            $dataFive = Api_Winchance_New_Ip_Submit_Field_Deal::stepFive();
            $data = array_merge($data, $dataFive);
        }
        $data['note'] = $request['note'];
        $data['admin_id'] = $request['admin_id'];
        $data['step'] = $request['step'];
        if ($request['step'] == 5) {
            $data['status'] = 1;
        }
        return $data;
    }

    // 审核拒绝
    static function rejectSubmit()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'rejectReason' => 'string',
        ), $_REQUEST);
        if (empty($request['id'])) {
            return self::request('error', '', 'ID异常！');
        }
        if (empty($request['rejectReason'])) {
            return self::request('error', '', '请填写拒绝理由!！');
        }
        $dat['status'] = -1;
        $dat['rejectReason'] = $request['rejectReason'];
        $dat['check_time'] = time();
        $res = Data_Mysql_Table_Winchance_Check::update(array('id' => $request['id']), $dat);
        if (!empty($res[0])) {
            return self::request('success', '', '操作成功！');
        } else {
            return self::request('error', '', '操作失败！');
        }
    }
}