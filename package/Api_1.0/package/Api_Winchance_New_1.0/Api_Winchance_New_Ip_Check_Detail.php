<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 20:27
 * IP 审核详情
 */
class Api_Winchance_New_Ip_Check_Detail extends Api
{
    static function detail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $_REQUEST);
        if (empty($request['id'])) {
            Func_Header::back('请求错误！');
        }
        $conditions['id'] = $request['id'];
        $conditions['status = ?'] = 0;
        $data = Data_Mysql_Table_Winchance_Check::select('*', $conditions);
        if (!empty($data)) {
            $data[0]['data'] = json_decode($data[0]['data'], 1);
            if (!empty($data[0]['ip_id'])) {
                $detail_cons['id =?'] = $data[0]['ip_id'];
                $detail_cons['status !=?'] = -1;
                $detail = Data_Mysql_Table_Winchance_New::select('*', $detail_cons);
                if (!empty($detail)) {
                    foreach ($data[0]['data'] as $k => $v) {
                        if (array_key_exists($k, $detail[0])) {
                            $detail[0][$k] = $v;
                        }
                    }
                    if ($data[0]['ip_step'] != 2) {
                        $detail[0]['age'] = json_decode($detail[0]['age'], 1);
                        $detail[0]['cover_picture'] = json_decode($detail[0]['cover_picture'], 1);
                    }
                    if ($data[0]['ip_step'] != 3) {
                        $detail[0]['agent'] = json_decode($detail[0]['agent'], 1);

                    }
                    if ($data[0]['ip_step'] != 4) {
                        $detail[0]['grant_fee'] = json_decode($detail[0]['grant_fee'], 1);
                    }
                    if ($data[0]['ip_step'] != 5) {
                        $detail[0]['agreement'] = json_decode($detail[0]['agreement'], 1);
                        $detail[0]['accessory'] = json_decode($detail[0]['accessory'], 1);
                    }
                }
            } else {
                foreach ($data[0]['data'] as $k => $v) {
                    $detail[0][$k] = $v;
                }
            }
//            if (!empty($detail[0]['city'])) {
//                $detail[0]['city'] = explode(',', $detail[0]['city']);
//            }
//            if (!empty($detail[0]['cooperating_mode'])) {
//                $detail[0]['cooperating_mode'] = explode(',', $detail[0]['cooperating_mode']);
//            }
            $detail[0]['ip_id'] = $data[0]['ip_id']; //已审核表的step为主
            $detail[0]['id'] = $data[0]['id'];
            $detail[0]['ip_step'] = $data[0]['ip_step']; //已审核表的step为主
            $detail[0]['admin_id'] = $data[0]['admin_id'];
            return $detail;
        }else{
            Func_Header::back('审核数据不存在！');
        }
    }
}