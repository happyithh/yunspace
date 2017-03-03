<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/7
 * Time: 17:10
 * 订单预订
 */
class Api_Order_Booking_Submit extends Api
{
    static function  handle($args = '')
    {
        Web_Account::handleIsLogin();
        Web_Account::handleAccountHasAuth('下单', 1);
        $request = Func_Input::filter(array(
            'id' => 'int',
            'start_date' => 'string',
            'end_date' => 'string',
            'memo' => 'string',
            'order_number'=>'int',
            'action'=>'string',
            'demand_id'=>'int',
        ), $_REQUEST);
        if (empty($request["id"])) {
            return self::request('error','','参数不完整！！');
        }
        if (empty($request["start_date"]) || empty($request["end_date"])) {
            return self::request('error','','请正确选择预订档期！！');
        }
        return self::handleOrderSubmit($request);
    }

    static function  handleOrderSubmit($args)
    {

        $action = $args['action'];
        switch ($action) {
            case 'set':
                $data = self::handleSetBookingSubmit($args);
                break;
            case 'product':
                $data = self::handleProductBookingSubmit($args);
                break;
            default:
                $data = self::request('error', '', '失败');
                break;
        }
        return $data;
    }
    /*
    * 产品预订
    * @param $args:数组参数
    * @return array
    */
    static function handleProductBookingSubmit($args){
        $requestData=$args;

        //开始结束时间验证
        if (!empty($requestData['start_date'])) {
            $requestData['start_time'] = strtotime($requestData['start_date']);
            $requestData['end_time'] = strtotime($requestData['end_date']);
            if ($requestData['start_time'] < time() || $requestData['start_time'] > $requestData['end_time']) {
                return self::request('error','','所选档期范围异常，请重新选择！');
            }
        }

        $oProduct = Web_Product_Info::getInstance();
        $oProduct->id = $requestData['id'];
        $productInfo = $oProduct->productInfo;

        //判断当前数量是否在可选预订数量范围内
        if(!empty($productInfo['attr_new']['计价单位'])){
            $min_number=$productInfo['attr_new']['计价下限'];
            $max_number=$productInfo['attr_new']['计价上限'];
            $requestData['order_number']=empty($requestData['order_number'])?$min_number:$requestData['order_number'];
            if($requestData['order_number'] < $min_number || $requestData['order_number'] > $max_number){
                return self::request('error','','请选择正确的预订数量');
            }
            //当单位价为“天”时，判断选择的数量是否和单位价一致
            if($productInfo['attr_new']['计价单位']=="天"){
                $days=round(($requestData['end_time']-$requestData['start_time'])/86400);
                if($days != $requestData['order_number']){
                    return self::request('error','','预订数量与预订档期天数不匹配');
                }
            }
        }else{
            $requestData['order_number']=1;
        }

        //已预订档期不可预订
        $s_conditions['product_id']=$requestData['id'];
        $s_conditions[]='status >0';
        $sr = Data_Mysql_Table_Product_Schedule::select('id,status,start_time,end_time',$s_conditions,'',100);
        if(!empty($sr)){
            foreach($sr as $k=>$v){
                if(($requestData['start_time'] >= $v['start_time'] && $requestData['start_time'] <= $v['end_time']) || ($requestData['end_time'] >= $v['start_time'] && $requestData['end_time'] <= $v['end_time']) || ($v['end_time'] >= $requestData['start_time'] && $v['end_time'] <= $requestData['end_time']) || ($v['start_time'] >= $requestData['start_time'] && $v['start_time'] <= $requestData['end_time'])){
                    return self::request('error','','所选档期有冲突，请重新选择！');
                }
            }
        }

        //获取该供应商绑定的账户
        $vendorAccountId = 0;
        $vendorName='';
        if ($productInfo['vendor_id']) {
            $vendorData = Data_Mysql_Table_Vendor_Info::select('{table}.vendor_account_id,{table}.vendor_name,{prefix}account.username,{prefix}account.phone', array('id' => $productInfo['vendor_id']), '', 999,'{table} LEFT JOIN {prefix}account ON {table}.vendor_account_id = {prefix}account.id');
            $vendorAccountId = $vendorData[0]['vendor_account_id'] ? $vendorData[0]['vendor_account_id'] : 0;
            $vendorName = $vendorData[0]['vendor_name'] ? $vendorData[0]['vendor_name'] : '';
            if ($vendorAccountId == $_SESSION['user']['id']) {
                return self::request('error','','买家卖家不能是同一个账号!');
            }
        }
        //获取推荐人信息和佣金比例
        $dwz=Data_Mysql_Table_Dwz_Record::select('{table}.*,{prefix}product_marketing.recommend_charges',array('pid'=>$requestData['id'],'uid'=>$_SESSION['user']['id']),'',1,'{table} LEFT JOIN {prefix}product_marketing ON {table}.pid={prefix}product_marketing.id');

        //获取需求人的account_id
        $buyer_account=0;
        if(!empty($requestData['demand_id'])){
            $demandInfo=Api_Demand_GetInfo::getInfo(array('demand_id'=>$requestData['demand_id']));
            if(!empty($demandInfo)){
                $buyer_account=$demandInfo['account_id'];
            }
        }

        $data = array(
            'order_no' => 'tmp_' . uniqid(),
            'buyer_account_id' => empty($buyer_account)?$_SESSION['user']['id']:$buyer_account,
            'order_title' => $productInfo['product_name'],
            'vendor_account_id' => $vendorAccountId,
            'vendor_name' => $vendorName,
            'deal_account_id' => empty($dwz[0])?0:$dwz[0]['shareid'], //TODO: 如果有经纪人推广则设置 经纪人几号和 佣金比例.
            'order_commission_deal_per' =>empty($dwz[0])?0:($dwz[0]['recommend_charges']/100),
            'vendor_id' => $productInfo['vendor_id'],
            'product_id' => $productInfo['id'],
            'start_time' => $requestData['start_date'] ? $requestData['start_time'] : 0,
            'end_time' => $requestData['end_date'] ? $requestData['end_time'] : 0,
            'remark' => $requestData['memo'],
            'order_price' => $productInfo['price']*$requestData['order_number'],
            'order_price_last' => 0,
            'order_price_pay' => 0,
            'order_status' => 0, //  0: 预定
            'order_detail' => array(
                'object_info' => $productInfo,
                'buyer_name' => $_SESSION['user']['fullname'],
                'buyer_phone' => $_SESSION['user']['phone'],
                'vendor_account_name'=>empty($vendorData[0]['username'])?'':$vendorData[0]['username'],
                'vendor_account_phone'=>empty($vendorData[0]['phone'])?'':$vendorData[0]['phone'],
                'order_number' => $requestData['order_number'],
                'ticket' => 0,//无发票
            ),
            'create_time' => time(),
            'update_time' => time(),
            'status' => 1,
        );
        //写入
        $r = Data_Mysql_Table_Order_Info::insert($data);
        if (!empty($r[0])) {
            //更新 订单号 order_no
            $data['order_no'] = 'A01' . str_pad($data['product_id'], 8, '0', STR_PAD_LEFT) . date('ymd') . str_pad($r[0] + 1912, 10, '0', STR_PAD_LEFT);
            Data_Mysql_Table_Order_Info::update($r[0], array('order_no' => $data['order_no']));
            //添加档期
            if ($data['start_time']) {
                Data_Mysql_Table_Product_Schedule::insert(array(
                    'product_id' => $data['product_id'],
                    'order_id' => $r[0],
                    'start_time' => $data['start_time'],
                    'end_time' => $data['end_time'],
                    'des' => $data['order_no'],
                    'status' => 1,
                ));
            }
            //更新产品的订单数
            Data_Mysql_Table_All_Count::subTable('_product')->exec('UPDATE {table}_product set count_order=count_order+1 where object_id='.$data['product_id'],true);

            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('产品预订',$r[0]);

            //发送邮件参数组合
            $noticeContent =array(
                'start_time'=>date('Y年m月d日',$data['start_time']),
                'end_time'=>date('Y年m月d日',$data['end_time']),
                'create_time'=>date('Y年m月d日H时i分s秒',$data['create_time']),
                'order_price'=>$data['order_price'],
                'buyer'=> $_SESSION['user']['fullname'],
                'product_id'=>$data['product_id']
            );
            //发短消息和邮件通知供应商有新订单
            Api_Order_Send_Message::sendNotice($data['order_no'],$vendorAccountId,$noticeContent);

            //转向
            return self::request('success',$data['order_no'],'预订成功,请等待供应商确认!');
        } else {
            return self::request('error','','操作发生异常,请稍候再试!');
        }
    }

    /*
     *套餐预订
     * @param $args:数组参数
     * @return array
     */
    static function handleSetBookingSubmit($args)
    {
        $requestData=$args;

        $oProductSet = Web_Product_Set_Info::getInstance();
        $oProductSet->id = $requestData['id'];
        $productSet = $oProductSet->info;

        //判断当前数量是否在可选预订数量范围内
        if(!empty($productSet['detail']['计价单位'])){
            $min_number=$productSet['detail']['计价下限'];
            $max_number=$productSet['detail']['计价上限'];
            $requestData['order_number']=empty($requestData['order_number'])?$min_number:$requestData['order_number'];
            if($requestData['order_number'] < $min_number || $requestData['order_number'] > $max_number){
                return self::request('error','','请选择正确的预订数量');
            }
            //当单位价为“天”时，判断选择的数量是否和单位价一致
            if($productSet['detail']['计价单位']=="天"){
                $days=round(($requestData['end_time']-$requestData['start_time'])/86400);
                if($days != $requestData['order_number']){
                    return self::request('error','','预订数量与预订档期天数不匹配');
                }
            }
        }else{
            $requestData['order_number']=1;
        }

        //开始结束时间验证
        if (!empty($requestData['start_date'])) {
            $requestData['start_time'] = strtotime($requestData['start_date']);
            $requestData['end_time'] = strtotime($requestData['end_date']);
            if($requestData['end_time'] > strtotime($productSet['attr_index']['结束时间'])){
                $requestData['end_time']=strtotime($productSet['attr_index']['结束时间']);
            }
            if (($requestData['start_time'] < time()) || ($requestData['start_time'] > $requestData['end_time'])) {
                return self::request('error','','所选档期范围异常，请重新选择！');
            }
            if (!empty($productSet['attr_index']['开始时间']) && ($requestData['start_time'] < strtotime($productSet['attr_index']['开始时间']) || $requestData['start_time'] > strtotime($productSet['attr_index']['结束时间'])  || $requestData['end_time'] >  strtotime($productSet['attr_index']['结束时间']) || $requestData['end_time'] < strtotime($productSet['attr_index']['开始时间']))) {
                return self::request('error','','所选档期范围不在有效期，请重新选择！');
            }
            //已预订档期不可预订
            $s_conditions['product_id']=$productSet['schedule_product_id'];
            $s_conditions[]='status >0';
            $sr = Data_Mysql_Table_Product_Schedule::select('id,status,start_time,end_time',$s_conditions,'',100);
            if(!empty($sr)){
                foreach($sr as $k=>$v){
                    if(($requestData['start_time'] >= $v['start_time'] && $requestData['start_time'] <= $v['end_time']) || ($requestData['end_time'] >= $v['start_time'] && $requestData['end_time'] <= $v['end_time']) || ($v['end_time'] >= $requestData['start_time'] && $v['end_time'] <= $requestData['end_time']) || ($v['start_time'] >= $requestData['start_time'] && $v['start_time'] <= $requestData['end_time'])){
                        return self::request('error','','所选档期有冲突，请重新选择！');
                    }
                }
            }
        }
        //获取该供应商绑定的账户
        $vendorAccountId = 0;
        $vendorName='';
        if ($productSet['vendor_id']) {
            $vendorData = Data_Mysql_Table_Vendor_Info::select('vendor_account_id,vendor_name', array('id' => $productSet['vendor_id']), '', 999);
            $vendorAccountId = $vendorData[0]['vendor_account_id'] ? $vendorData[0]['vendor_account_id'] : 0;
            $vendorName = $vendorData[0]['vendor_name'] ? $vendorData[0]['vendor_name'] : '';
            if ($vendorAccountId == $_SESSION['user']['id']) {
                return self::request('error','','买家卖家不能是同一个账号');
            }
        }
        //获取推荐人信息
        $dwz=Data_Mysql_Table_Dwz_Record::select('{table}.*,{prefix}product_marketing_set.recommend_charges',array('sid'=>$requestData['id'],'uid'=>$_SESSION['user']['id']),'',1,'{table} LEFT JOIN {prefix}product_marketing_set ON {table}.sid={prefix}product_marketing_set.id');

        $data = array(
            'order_no' => 'tmp_' . uniqid(),
            'order_title' => $productSet['set_name'],
            'buyer_account_id' => $_SESSION['user']['id'],
            'vendor_account_id' => $vendorAccountId,
            'vendor_name' => $vendorName,
            'deal_account_id' => empty($dwz[0])?0:$dwz[0]['shareid'], //TODO: 如果有经纪人推广则设置 经纪人几号和 佣金比例.
            'order_commission_deal_per' =>empty($dwz[0])?0:($dwz[0]['recommend_charges']/100),
            'vendor_id' => $productSet['vendor_id'],
            'product_set_id' => $requestData['id'],
            'start_time' => $requestData['start_date'] ? $requestData['start_time'] : 0,
            'end_time' => $requestData['start_date'] ? $requestData['end_time'] : 0,
            'remark' => $requestData['memo'],
            'order_price' => $productSet['detail']['套餐价']*$requestData['order_number'],
            'order_price_last' => 0,
            'order_price_pay' => 0,
            'order_status' => 0, //  0: 预定;
            'order_detail' => array(
                'object_info' => $productSet,
                'buyer_name' => $_SESSION['user']['fullname'],
                'order_number' => $requestData['order_number'],
                'ticket' => 0,//无发票
            ),
            'create_time' => time(),
            'update_time' => time(),
            'status' => 1,
        );
        //写入
        $r = Data_Mysql_Table_Order_Info::insert($data);
        if (!empty($r[0])) {
            //更新 订单号 order_no
            $data['order_no'] = 'S01' . str_pad($data['product_set_id'], 8, '0', STR_PAD_LEFT) . date('ymd') . str_pad($r[0] + 1912, 10, '0', STR_PAD_LEFT);
            Data_Mysql_Table_Order_Info::update($r[0], array('order_no' => $data['order_no']));
            if ($data['start_time']) {
                Data_Mysql_Table_Product_Schedule::insert(array(
                    'product_id' => $productSet['schedule_product_id'],
                    'order_id' => $r[0],
                    'start_time' => $data['start_time'],
                    'end_time' => $data['end_time'],
                    'des' => $data['order_no'],
                    'status' => 1,
                ));
            }
            //更新套餐的订单数
            Data_Mysql_Table_All_Count::subTable('_set')->exec('UPDATE {table}_set set count_order=count_order+1 where object_id='.$data['product_set_id'],true);

            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('套餐预订',$r[0]);

            //发送邮件参数组合
            $noticeContent =array(
                'start_time'=>date('Y年m月d日',$data['start_time']),
                'end_time'=>date('Y年m月d日',$data['end_time']),
                'create_time'=>date('Y年m月d日H时i分s秒',$data['create_time']),
                'order_price'=>$data['order_price'],
                'buyer'=> $_SESSION['user']['fullname'],
                'product_set_id'=>$data['product_set_id']
            );

            //发短消息和邮件通知供应商有新订单
            Api_Order_Send_Message::sendNotice($data['order_no'],$vendorAccountId,$noticeContent);

            return self::request('success',$data['order_no'],'预订成功,请等待工作人员确认档期!');
        } else {
            return self::request('error','','操作发生异常,请稍候再试!');
        }
    }

}