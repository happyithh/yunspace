<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-12-28
 * Time: 下午14:00
 * 合作咨询和查询档期和价格
 */
class Api_Demand_New_Events extends Api
{

    //查询档期和价格
    static function handleNewEventsDemand()
    {
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
            'content' => 'string',
            'start_time' => 'string',
            'end_time' => 'string',
            'from_type' => 'int',
            'object_id' => 'int',
            'object_ids' => 'string',
            'object_names' => 'string',
            'object_name' => 'string',
            'object_type' => 'string',
            'demand_city' => 'string',
            'is_mobile' => 'int',
            'item_name'=>'string',
            'item_id'=>'int',
            'price'=>'string',
            'change_date'=>'int',
            'active_date'=>'int',
            'date_start'=>'string',
            'date_end'=>'string',
            'date_activity'=>'string',
        ), $_REQUEST);
//        if (empty($request['content'])) {
//            return self::request('error', '', '咨询内容必须填写!');
//        }
        if (strlen($request['content']) > 500) {
            return self::request('error', '', '您的咨询内容输入过多!');
        }
        if (empty($_SESSION['user']) && empty($request['phone'])) {
            return self::request('error', '', '未登录用户联系电话必须填写!');
        }
        $demand_data = array(
            '联系电话' => $request['phone'],
            '联系人' => $request['username'],
            '具体要求' => $request['content'],
            '活动城市' => $request['demand_city'],
            '活动预算' => $request['price'],
            '活动类型' => $request['date_activity'],
            '可改期' => $request['change_date']==1?'是':'否',
            '活动日期' => $request['date_start'].'-'.$request['date_end'],
        );
        if(!empty($request['item_id'])){
            $demand_data['空间名称']= $request['item_name'];
            $demand_data['子空间ID']= $request['item_id'];
        }
        if(!empty($request['object_ids'])){
            $demand_data['多个场地名称'] = $request['object_names'];
            $demand_data['多个场地ID'] = $request['object_ids'];
        }else{
            $demand_data['场地名称'] = $request['object_name'];
            $demand_data['场地ID'] = $request['object_id'];
        }
        if (!empty($request['demand_other'])) {
            $demand_data['具体要求'] = $demand_data['具体要求'] . "--还需要其他的配套服务";
        }
        if ($request['from_type'] == 1) {
            if(!empty($request['is_mobile'])){
                $demand_type = '咨询价格和档期M';  //手机端咨询档期和价格
            }else{
                $demand_type = '咨询价格和档期';
            }
            if (empty($request['start_time']) || empty($request['end_time'])) {
                return self::request('error', '', '请选择开始时间和结束时间!');
            }
            if ($request['start_time'] > $request['end_time']) {
                return self::request('error', '', '请正确选择开始时间和结束时间!');
            }
            $demand_data['开始时间'] = $request['start_time'];
            $demand_data['结束时间'] = $request['end_time'];
        } elseif ($request['from_type'] == 2) {
            $demand_type = '文创项目合作';
        } else {
            $demand_type = '合作咨询';
        }

        $account = Api_Demand_Create::getAccountByPhone(array('phone' => $request['phone']));
        //重复判断   1/21  zzc
        $check_table = "{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id =t2.id";
        $check_where['(t1.phone=? OR t2.customer_phone=?) AND t1.demand_type=?'] = array($request['phone'], $request['phone'], trim($demand_type));

        $is_exists = Data_Mysql_Table_Demand::select('t1.id,t1.demand_status,t1.create_time,t2.step', $check_where, 'ORDER BY t1.id DESC', 1, $check_table);
        if ((!empty($is_exists[0]) && ($is_exists[0]['demand_status'] >= 0) && ($is_exists[0]['create_time'] >= time() - 7 * 24 * 3600))
            ||
            (!empty($is_exists[0]['step']) && ($is_exists[0]['step'] >= 0 && $is_exists[0]['step'] != 100))
        ) {
            $is_create = false;

        } else {
            $is_create = true;
        }
        if (false == $is_create) {
            //已经有同类型的需求，则不新建需求，存储咨询的数据
            if(!empty($request['object_ids'])){
                $object_ids = explode(',',$request['object_ids']);
                $object_name =  explode(',',$request['object_names']);
                foreach($object_ids as $k=>$v){
                    $event_data['demand_id'] = $is_exists[0]['id'];
                    $event_data['object_id'] = $v;
                    $event_data['object_name'] = $object_name[$k];
                    $event_data['object_type'] = $request['object_type'];
                    $event_data['demand'] = $demand_data;
                    $event_data['create_time'] = time();
                    Data_Mysql_Table_Demand_Events::update($event_data);
                }
            }else{
                $event_data['demand_id'] = $is_exists[0]['id'];
                $event_data['object_id'] = $request['object_id'];
                $event_data['object_name'] = $request['object_name'];
                $event_data['object_type'] = $request['object_type'];
                $event_data['demand'] = $demand_data;
                $event_data['create_time'] = time();
                Data_Mysql_Table_Demand_Events::update($event_data);
            }
            //更新该需求的创建时间
            Data_Mysql_Table_Demand::update(array("id" => $is_exists[0]['id'], 'create_time' => time()));
            return Api::request('success', '', '您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
        } else {
            return Api_Demand_Create::create(array('demand' => $demand_data,
                'phone' => $request['phone'],
                'demand_type' => $demand_type,
                'demand_name' => 'New-' . $demand_type,
                'account_id' => $account['id'],
                'object_id' => $request['object_id'],
                'object_name' => $request['object_name'],
                'object_type' => $request['object_type'],
            ));
        }

    }
}




