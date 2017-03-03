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
    'price' => 'int',
    'start_date' => 'string',
    'end_date' => 'string',
    'event_type' => 'array',
    'memo' => 'string',
), $_REQUEST['data']);
//开始结束时间验证
if ($requestData['is_schedule']) {
    $requestData['start_time'] = strtotime($requestData['start_date']);
    $requestData['end_time'] = strtotime($requestData['end_date']);
    if ($requestData['start_time'] < time() || $requestData['start_time'] > $requestData['end_time']) {
        Func_Header::back('所选档期范围异常，请重新选择！');
    }
    $requestData['price'] = ($requestData['end_time'] - $requestData['start_time']) / 86400;
} else {
    $requestData['price'] = 1;
}
$requestData['event_type'] = $requestData['event_type'] ? implode(', ', $requestData['event_type']) : '';
$rs = Data_Mysql_Table_Product_Info::select('id, vendor_id, category_id, product_name, price, attr, des', array('id' => $_REQUEST['id'], 'status' => 1));
if (empty($rs[0]['id'])) {
    Func_Header::notFound();
}
$productInfo = $rs[0];
//获取该供应商绑定的账户
$vendorAccountId = 0;

if ($productInfo['vendor_id']) {
    $vendorData = Data_Mysql_Table_Vendor_Info::select('vendor_account_id,vendor_name', array('id' => $productInfo['vendor_id']), '', 999);
    $vendorAccountId = $vendorData[0]['vendor_account_id'] ? $vendorData[0]['vendor_account_id'] : 0;
    $vendorName = $vendorData[0]['vendor_name'] ? $vendorData[0]['vendor_name'] : '';
    if ($vendorAccountId == $_SESSION['user']['id']) {
        Func_Header::back(' 买家卖家不能是同一个账号!');
    }
}
//获取推荐人信息和佣金比例
$dwz=Data_Mysql_Table_Dwz_Record::select('{table}.*,{prefix}product_marketing.recommend_charges',array('pid'=>$productInfo['id'],'uid'=>$_SESSION['user']['id']),'',1,'{table} LEFT JOIN {prefix}product_marketing ON {table}.pid={prefix}product_marketing.id');

$data = array(
    'order_no' => 'tmp_' . uniqid(),
    'order_title' => $productInfo['product_name'],
    'buyer_account_id' => $_SESSION['user']['id'],
    'vendor_account_id' => $vendorAccountId,
    'vendor_name' => $vendorName,
    'deal_account_id' => empty($dwz[0])?0:$dwz[0]['shareid'], //TODO: 如果有经纪人推广则设置 经纪人几号和 佣金比例.
    'order_commission_deal_per' => empty($dwz[0])?0:($dwz[0]['recommend_charges']/100),
    'vendor_id' => $productInfo['vendor_id'],
    'product_id' => $productInfo['id'],
    'product_category_id' => $productInfo['category_id'],
    'start_time' => $requestData['is_schedule'] ? $requestData['start_time'] : 0,
    'end_time' => $requestData['is_schedule'] ? $requestData['end_time'] : 0,
    'remark' => $requestData['memo'],
    'order_price' => abs($requestData['price'] * $productInfo['price'] / 100),
    'order_price_last' => 0,
    'order_price_pay' => 0,
    'order_status' => 0, //  0: 预定;  5: 审核通过;  6:审核未通过;  7:管理员转单;  10:协议确认;   11:供应商签约;   12:买家签约;   15:买家付款;  20:追加条款议定;  90:订单完成;   91:订单投拆;  -n:关闭
    'order_payment_percent' => 0, //0-1000  千分比
    'order_detail' => array(
        'attr' => json_decode($productInfo['attr'], 1),
        'des' => $productInfo['des'],
        'price' => $productInfo['price']/100,
        'size' => $requestData['price'],
        'event_type' => $requestData['event_type'],
    ),
    'create_time' => time(),
    'update_time' => time(),
    'status' => 1,);
//写入
$r = Data_Mysql_Table_Order_Info::insert($data);
if (!empty($r[0])) {
    //更新 订单号 order_no
//    $data['order_no'] = 'A' . str_pad($data['product_category_id'], 5, '0', STR_PAD_LEFT) . str_pad($data['product_id'], 8, '0', STR_PAD_LEFT) . date('ymd') . str_pad($r[0] + 1912, 10, '0', STR_PAD_LEFT);
    $data['order_no'] = 'A' . str_pad($data['product_id'], 8, '0', STR_PAD_LEFT) . date('ymd') . str_pad($r[0] + 1912, 10, '0', STR_PAD_LEFT);
    Data_Mysql_Table_Order_Info::update($r[0], array('order_no' => $data['order_no']));
    if ($data['start_time']) {
        Data_Mysql_Table_Product_Schedule::insert(array(
            'product_id' => $data['product_id'],
            'order_id' => $r[0],
            'start_time' => $data['start_time'],
            'end_time' => $data['end_time'],
            'des' => $data['order_no'],
            'status' => 0,
        ));
    }
    //更新产品的订单数
    $tmp = Data_Mysql_Table_Order_Info::select('count(id) as c', array(
        'product_id' => $data['product_id'],));
    if (!empty($tmp[0]['c'])) {
        Data_Mysql_Table_Product_Info::update($data['product_id'], array(
            'counter_order' => $tmp[0]['c'],
        ));
    }
    //发送邮件参数组合
    $noticeContent =array(
        'start_time'=>date('Y年m月d日',$data['start_time']),
        'end_time'=>date('Y年m月d日',$data['end_time']),
        'create_time'=>date('Y年m月d日H时i分s秒',$data['create_time']),
        'order_price'=>$data['order_price'],
        'buyer'=> $_SESSION['user']['fullname']
    );
    //获取产品名称
    if(!empty($data['product_id'])){
        $product_name = Data_Mysql_Table_Product_Info::select('product_name',array('id'=>$data['product_id']));
        if(!empty($product_name[0])){
            $noticeContent['product_name'] = $product_name[0]['product_name'];
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
    Func_Header::to('预订成功,请等待供应商确认!', Core::$urls['root'] . 'order_info/' . $data['order_no']);
} else {
    Func_Header::back('操作发生异常,请稍候再试!');
}