<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/10
 * Time: 10:48
 * IP 详情
 */
class Api_Winchance_New_Ip_Detail extends Api
{
    static function detail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'step' => 'int',
            'check_id'=>'int',
        ), $_REQUEST);
        if (empty($request['id']) && empty($request['check_id'])) {
            Func_Header::back('请求错误！');
        }
        // 查询合作阶段是否有保存的详情（仅针对操作者）
        if(empty($request['id']) && !empty($request['check_id'])){
            // 第一次审核被拒绝数据
            $con_check['id =?']=$request['check_id'];
            $data = Data_Mysql_Table_Winchance_Check::select("*",$con_check);
            if(!empty($data[0])){
                $data[0]['data'] = json_decode($data[0]['data'],1);
                $newData[0] = $data[0]['data'];
                $newData[0]['admin_id'] = $data[0]['admin_id'];
                $newData[0]['step'] = $data[0]['ip_step'];
                $newData[0]['check_id'] = $data[0]['id'];
                unset($data[0]['data']);
                return $newData;
            }
        }else{
            $con_draft['ip_id = ?'] = $request['id'];
            $con_draft[] = '(status =0 OR status =2 OR status=-1 OR status=1)';
            @session_start();
            $con_draft['operator_id = ?'] = empty($_SESSION['administrator']['id']) ? '0' : $_SESSION['administrator']['id'];
//            Data_Mysql_Table_Winchance_Check::debug(1);
            $draft = Data_Mysql_Table_Winchance_Check::select('*', $con_draft, 'order by update_time desc' , 5);
            krsort($draft);
            // 主表中的ip内容
            $conditions['status !=?'] = -1;
            $conditions['id'] = $request['id'];
            $data = Data_Mysql_Table_Winchance_New::select('*', $conditions);
            if (!empty($data)) {
                if (!empty($draft)) {
                    /*
                         *  显示信息以草稿为主
                         * */
                    foreach ($draft as $k => $v) {
                        $draft[$k]['data'] = json_decode($v['data'], 1);
                        foreach ($draft[$k]['data'] as $kk => $vv) {
                            if (array_key_exists($kk, $data[0])) {
                                $data[0][$kk] = $vv;
                            }
                        }
                    }
                }
                return self::arrayDeal($data);
            }
        }
    }

    // 处理数据
    static function arrayDeal($data)
    {
        if (!empty($data[0]['age']) && !is_array($data[0]['age'])) {
            $data[0]['age'] = json_decode($data[0]['age'], 1);
        }
        if (!empty($data[0]['cover_picture']) && !is_array($data[0]['cover_picture'])) {
            $data[0]['cover_picture'] = json_decode($data[0]['cover_picture'], 1);
        }
        if (!empty($data[0]['agent']) && !is_array($data[0]['agent'])) {
            $data[0]['agent'] = json_decode($data[0]['agent'], 1);
        }
        if (!empty($data[0]['grant_fee']) && !is_array($data[0]['grant_fee'])) {
            $data[0]['grant_fee'] = json_decode($data[0]['grant_fee'], 1);
        }
//        if (!empty($data[0]['schedule']) && !is_array($data[0]['schedule'])) {
//            $data[0]['schedule'] = json_decode($data[0]['schedule'], 1);
//        }
        if (!empty($data[0]['agreement']) && !is_array($data[0]['agreement'])) {
            $data[0]['agreement'] = json_decode($data[0]['agreement'], 1);
        }
        if (!empty($data[0]['accessory']) && !is_array($data[0]['accessory'])) {
            $data[0]['accessory'] = json_decode($data[0]['accessory'], 1);
        }
//        if(!empty($data[0]['city'])){
//            $data[0]['city'] = explode(',',$data[0]['city']);
//        }
//        if(!empty($data[0]['cooperating_mode'])){
//            $data[0]['cooperating_mode'] = explode(',',$data[0]['cooperating_mode']);
//        }
//        q($data);
        return $data;
    }

}