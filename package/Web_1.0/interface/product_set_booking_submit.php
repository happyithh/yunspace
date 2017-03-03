<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 14:38
 */
Web_Account::handleIsLogin();
Web_Account::handleAccountHasAuth('下单', 1);
/**
 * 开始预订
 */
if (empty($_REQUEST['id']) || empty($_REQUEST['data'])) {
    Func_Header::notFound();
}
$requestData = Func_Input::filter(array(
    'is_schedule' => 'int',
    'start_date' => 'string',
    'agreement' => 'int',
    'memo' => 'string',
    'order_number'=>'int',
), $_REQUEST['data']);
$oProductSet = Web_Product_Set_Info::getInstance();
$oProductSet->id = $_REQUEST['id'];
$productSet = $oProductSet->info;
if (empty($requestData['agreement'])) {
    Func_Header::back('请先同意云space套餐协议！');
}
//判断当前数量是否在可选预订数量范围内
if(!empty($productSet['detail']['计价单位'])){
    $min_number=$productSet['detail']['计价下限'];
    $max_number=$productSet['detail']['计价上限'];
    $requestData['order_number']=empty($requestData['order_number'])?$min_number:$requestData['order_number'];
    if($requestData['order_number'] < $min_number || $requestData['order_number'] > $max_number){
        Func_Header::back('请选择正确的预订数量！');
    }
}else{
    $requestData['order_number']=1;
}
//开始结束时间验证
if (!empty($requestData['is_schedule'])) {
    $requestData['start_time'] = strtotime($requestData['start_date']);
    $hours=empty($productSet['hours'])?24:$productSet['hours'];
    $days=ceil($hours/24);
    $requestData['end_time'] = strtotime($requestData['start_date'])+($days-1)*86400;
    if($requestData['end_time'] > strtotime($productSet['attr_index']['结束时间'])){
        $requestData['end_time']=strtotime($productSet['attr_index']['结束时间']);
    }

    if ($requestData['start_time'] < time()) {
        Func_Header::back('所选档期范围异常，请重新选择！');
    }
    if (!empty($productSet['attr_index']['开始时间']) && ($requestData['start_time'] < strtotime($productSet['attr_index']['开始时间']) || $requestData['start_time'] > strtotime($productSet['attr_index']['结束时间'])  || $requestData['end_time'] >  strtotime($productSet['attr_index']['结束时间']) || $requestData['end_time'] < strtotime($productSet['attr_index']['开始时间']))) {
        Func_Header::back('所选档期范围不在有效期，请重新选择！');
    }
    //已预订档期不可预订
    $s_conditions['product_id']=$productSet['schedule_product_id'];
    $s_conditions[]='`status` >=0';
    $sr = Data_Mysql_Table_Product_Schedule::select('id,status,start_time,end_time',$s_conditions,'',100);
    if(!empty($sr)){
        foreach($sr as $k=>$v){
            if(($requestData['start_time'] >= $v['start_time'] && $requestData['start_time'] <= $v['end_time']) || ($requestData['end_time'] >= $v['start_time'] && $requestData['end_time'] <= $v['end_time']) || ($v['end_time'] >= $requestData['start_time'] && $v['end_time'] <= $requestData['end_time']) || ($v['start_time'] >= $requestData['start_time'] && $v['start_time'] <= $requestData['end_time'])){
                Func_Header::back('所选档期有冲突，请重新选择！');
            }
        }
    }
//    $days = round(($requestData['end_time'] - $requestData['start_time']) / 86400) + 1;
    //获取当前所选档期中不包含周六周日的天数
//    if (empty($productSet['attr_index']['节假日可选'])) {
//        $days = Web_Product_Set_Info::getRestDays($requestData['start_time'], $requestData['end_time']);
//    }
    //获取当前所选档期中不包含工作日的天数
//    if (empty($productSet['attr_index']['工作日可选'])) {
//        $workingdays = Web_Product_Set_Info::getRestDays($requestData['start_time'], $requestData['end_time']);
//        $days = $days - $workingdays;
//    }
} else {
    $days = 1;
}
//获取该供应商绑定的账户
$vendorAccountId = 0;

$vendorName='';
if ($productSet['vendor_id']) {
    $vendorData = Data_Mysql_Table_Vendor_Info::select('vendor_account_id,vendor_name', array('id' => $productSet['vendor_id']), '', 999);
    $vendorAccountId = $vendorData[0]['vendor_account_id'] ? $vendorData[0]['vendor_account_id'] : 0;
    $vendorName = $vendorData[0]['vendor_name'] ? $vendorData[0]['vendor_name'] : '';
    if ($vendorAccountId == $_SESSION['user']['id']) {
        Func_Header::back(' 买家卖家不能是同一个账号!');
    }
}
//获取推荐人信息
$dwz=Data_Mysql_Table_Dwz_Record::select('{table}.*,{prefix}product_marketing_set.recommend_charges',array('sid'=>$productSet['id'],'uid'=>$_SESSION['user']['id']),'',1,'{table} LEFT JOIN {prefix}product_marketing_set ON {table}.sid={prefix}product_marketing_set.id');

$data = array(
    'order_no' => 'tmp_' . uniqid(),
    'order_title' => $productSet['set_name'],
    'buyer_account_id' => $_SESSION['user']['id'],
    'vendor_account_id' => $vendorAccountId,
    'vendor_name' => $vendorName,
    'deal_account_id' => empty($dwz[0])?0:$dwz[0]['shareid'], //TODO: 如果有经纪人推广则设置 经纪人几号和 佣金比例.
    'order_commission_deal_per' =>empty($dwz[0])?0:($dwz[0]['recommend_charges']/100),
    'vendor_id' => $productSet['vendor_id'],
    'product_set_id' => $_REQUEST['id'],
    'product_category_id' => $productSet['category_id'],
    'start_time' => $requestData['is_schedule'] ? $requestData['start_time'] : 0,
    'end_time' => $requestData['is_schedule'] ? $requestData['end_time'] : 0,
    'remark' => $requestData['memo'],
    'order_price' => $productSet['detail']['套餐价']*$requestData['order_number'],
    'order_price_last' => 0,
    'order_price_pay' => 0,
    'order_status' => 0, //  0: 预定;  5: 审核通过;  6:审核未通过;  7:管理员转单;  10:协议确认;   11:供应商签约;   12:买家签约;   15:买家付款;  20:追加条款议定;  90:订单完成;   91:订单投拆;  -n:关闭
    'order_payment_percent' => 0, //0-1000  千分比
    'order_detail' => array(
        'set_info' => $productSet,
        'detail_data' => $oProductSet->detail,
        'attr_index' => $productSet['attr_index'],
        'version' => $productSet['version'],
        'days' => $days,
        'order_number' => $requestData['order_number'],
        'products' => $oProductSet->products,
        'ticket' => 0,//无发票
    ),
    'create_time' => time(),
    'update_time' => time(),
    'status' => 1,);
//写入
$r = Data_Mysql_Table_Order_Info::insert($data);
if (!empty($r[0])) {
    //更新 订单号 order_no
    $data['order_no'] = 'S' . str_pad($data['product_set_id'], 8, '0', STR_PAD_LEFT) . date('ymd') . str_pad($r[0] + 1912, 10, '0', STR_PAD_LEFT);
    Data_Mysql_Table_Order_Info::update($r[0], array('order_no' => $data['order_no']));
    if ($data['start_time']) {
        Data_Mysql_Table_Product_Schedule::insert(array(
            'product_id' => $productSet['schedule_product_id'],
            'order_id' => $r[0],
            'start_time' => $data['start_time'],
            'end_time' => $data['end_time'],
            'des' => $data['order_no'],
            'status' => 0,
        ));
    }
    //更新产品的订单数
    $tmp = Data_Mysql_Table_Order_Info::select('count(id) as c', array(
        'product_set_id' => $data['product_set_id'],));
    if (!empty($tmp[0]['c'])) {
        Data_Mysql_Table_Product_Set::update($data['product_set_id'], array(
            'counter_order' => $tmp[0]['c'],
        ));
    }

    //添加订单追踪信息
    $content = '套餐预订';
    $order = Data_Mysql_Table_Order_Info::select('order_detail', $r[0]);
    $order_detail = json_decode($order[0]['order_detail'], 1);
    $track_info = array('更新时间' => time(), '操作内容' => $content, '操作人' => '采购方');
    if (!empty($order_detail['order_tracking'])) {
        $order_detail['order_tracking'][count($order_detail['order_tracking'])] = $track_info;
    } else {
        $order_detail['order_tracking'][0] = $track_info;
    }
    Data_Mysql_Table_Order_Info::update($r[0], array(
        'order_detail' => $order_detail,
    ));

    //发送邮件参数组合
    $noticeContent =array(
        'start_time'=>date('Y年m月d日',$data['start_time']),
        'end_time'=>date('Y年m月d日',$data['end_time']),
        'create_time'=>date('Y年m月d日H时i分s秒',$data['create_time']),
        'order_price'=>$data['order_price'],
        'buyer'=> $_SESSION['user']['fullname']
    );
    //获取套餐名称
    if(!empty($data['product_set_id'])){
        $product_name = Data_Mysql_Table_Product_Set::select('set_name',array('id'=>$data['product_set_id']));
        if(!empty($product_name[0])){
            $noticeContent['product_name'] = $product_name[0]['set_name'];
        }
    }
    //发短消息和邮件通知供应商有新订单
    if (!$vendorAccountId) {
        //通知超级供应商账号的手机号码, 和客服
        $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
    } else {
        $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => $vendorAccountId));
    }
    if (!empty($vendorInfo[0]['phone'])) {
        Web_Message::newOrderNotice($vendorInfo[0]['phone'], $data['order_no']);
    }
    if (!empty($vendorInfo[0]['email'])) {
        Web_Message::newOrderNoticeEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], $data['order_no'],$noticeContent);
    }
    //转向
//    Func_Header::to('预订成功,请等待工作人员确认档期!', Core::$urls['root'] . 'product_set_order_info/' . $data['order_no'].'?tab=1');
    Func_Header::toTplNoTime('我们正在奋力确认档期，15分钟内会有工作人员与您联系，稍后您可到“采购管理-待审核订单”中查看结果。<div class="reg_end_div"><span class="reg_end_span"><a href="http://'.Core::$urls['host'].'/user_center/user_admin/order?status=1">采购管理</a></span><a class="reg_end_a" href="http://'.Core::$urls['host'].'/product_set_order_info/'.$data['order_no'].'">回到订单详情</a></div>');
} else {
    Func_Header::back('操作发生异常,请稍候再试!');
}