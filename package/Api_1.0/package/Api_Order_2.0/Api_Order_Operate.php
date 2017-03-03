<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/9
 * Time: 10:10
 * 订单操作
 */
class Api_Order_Operate extends Api
{
    static $_orderInfo;
    static function  handle($args = '')
    {
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'action' => 'string',
            'order_no' => 'string',
        ), $_REQUEST);
        if (empty($request['order_no']) || empty($request['action'])) {
            return self::request('error','','参数错误！！');
        }
        return self::handleOrder($request);
    }
    static function handleOrder($args)
    {
        $rs=Api_Order_Info::getOrderInfo($args['order_no']);
        if($rs['status']==0){
            return self::request('error','','操作错误！！');
        }
        self::$_orderInfo = $rs['data'];
        $action = $args['action'];
        switch ($action) {
            case 'cancel':
                $data = self::handleCancel();
                break;
            case 'confirm_cancel':
                $data = self::handleConfirmCancel();
                break;
            case 'refuse_cancel':
                $data = self::handleRefuseCancel();
                break;
            case 'pending':
                $data=self::handlePending();
                break;
            case 'evaluate':
                $data=self::handleEvaluate();
                break;
            case 'add_conform':
                $data=self::handleAddConform();
                break;
            case 'refuse_conform':
                $data=self::handleRefuseConform();
                break;
            case 'conform_delete':
                $data=self::handleDeleteConform();
                break;
            case 'conform_sign':
                $data=self::handleConformSign();
                break;
            case 'vendor_complete':
                $data=self::handleOrderComplete();
                break;
            case 'buyer_create_pay':
                $request=Func_Input::filter(array('名称'=>'string','金额'=>'float','支付备注'=>'string'),$_REQUEST);
                if(empty($request['金额']) || $request['金额'] <0 || !is_numeric($request['金额'])){
                    return self::request('error','','请正确填写支付金额！！');
                }
                if(empty($request['名称'])){
                    return self::request('error','','支付备注必须填写！！');
                }
                return Api_Order_Normal_Api::resolveCreatePaymentInfo($request,self::$_orderInfo);
                break;
            case 'delete_pay':
                $request=Func_Input::filter(array('payment_id'=>'string','amount'=>'string'));
                return Api_Order_Normal_Api::deletePaymentInfo($request['payment_id'],$request['amount'],self::$_orderInfo);
                break;
            case 'transfer_pay':
                $data=self::handleTransferPay();
                break;
            case 'confirm_transfer':
                $data=self::handleConfirmPay();
                break;
            case 'not_confirm_transfer':
                $data=self::handleNotConfirmPay();
                break;
            case 'change_bank':
                $data=self::handleChangeBank();
                break;
            default:
                $data = self::request('error', '', '失败');
                break;
        }
        return $data;
    }
    /*
     *改变收款账户
     */
    static function handleChangeBank(){
        $request=Func_Input::filter(array('bank_id'=>'string','bank_info'=>'string'),$_REQUEST);
        $order_detail=self::$_orderInfo['order_detail'];
        $order_detail['bank_cash']=empty($request['bank_id'])?0:$request['bank_id'];
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_detail' => $order_detail,
        ));
        if (empty($r[0])) {
            return self::request('error','','更换收款银行失败！');
        }else{
            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('更换收款账户为('.$request['bank_info'].')',self::$_orderInfo['id'],'服务方');
            return self::request('success','','您已更换收款账户为('.$request['bank_info'].')');
        }

    }
   /*
    *线下支付信息提交
    */
    static function handleTransferPay(){
        $request=Func_Input::filter(array('名称'=>'string','金额'=>'float','支付备注'=>'string','payment_id'=>'string','transfer_info'=>'array'),$_REQUEST);
        if(empty($request['金额']) || $request['金额'] <0 || !is_numeric($request['金额'])){
            return self::request('error','','请正确填写支付金额！！');
        }
        if(empty($request['名称'])){
            return self::request('error','','支付备注必须填写！！');
        }
        if(empty($request['transfer_info'])){
            return self::request('error','','请上传支付凭证！！');
        }
        $payment_info['名称']=$request['名称'];
        $payment_info['金额']=$request['金额'];
        $payment_info['支付备注']=$request['支付备注'];
        //创建线下支付的支付节点
        if(empty($request['payment_id'])){
            $rs=Api_Order_Normal_Api::resolveCreatePaymentInfo($payment_info,self::$_orderInfo);
            if(!empty($rs['data'])){
                $payment_id=$rs['data'];
            }else{
                return $rs;
            }
        }else{
            $payment_info['payment_id']=$request['payment_id'];
            $rs=Api_Order_Normal_Api::updatePaymentInfo($payment_info,self::$_orderInfo);
            if(empty($rs['status'])){
                return $rs;
            }
            $payment_id=$request['payment_id'];
        }
        //更新线下支付
        if(!empty($payment_id)){
            $payment = Finance_Payment::getPaymentInfoById($payment_id);
            if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
                return self::request('error','','未找到该笔款项！！');
            }
            if (!empty($payment['payment_time'])) {
                return self::request('error','','该笔款项已支付!');
            }
            Web_Account::handleIsLogin();
            //添加支付信息
            $payment_data['order_id']= $payment['order_id'];
            $payment_data['order_no'] = $payment['payment_detail']['order_no'];
            $payment_data['buyer_account_id'] = $payment['account_id'];
            $payment_data['vendor_id'] = $payment['target_account_id'];
            $payment_data['payment_id'] = $payment['payment_id'];
            $payment_data['payment_amount'] =$payment['amount'];
            $payment_data['payment_status'] = -1;
            $payment_data['payment_method'] = '线下支付';
            $payment_data['payment_info']=array(
                '收款对象'=>$payment['payment_detail']['getpay_account_name'],
                '付款对象'=>$payment['payment_detail']['pay_account_name'],
            );
            $payment_data['payment_info']['media'] = $request['transfer_info'];
            //获取对账单的支付信息
            $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('payment_id'=>$payment['payment_id']));
            if(empty($payment_info[0])){
                $r=Data_Mysql_Table_Order_Payment::insert($payment_data);
            }else{
                $r=Data_Mysql_Table_Order_Payment::update($payment_info[0]['id'],$payment_data);
            }
            if (empty($r[0])) {
                return self::request('error','','操作失败，请稍候再试或联系客服人员！！');
            }else{
                //添加订单追踪信息
                Api_Order_Normal_Api::setTracking('提交线下支付信息',self::$_orderInfo['id'],'采购方');
                return self::request('success','','提交成功，等待供应商确认！！');
            }
        }
    }

    /*
     *确认线下支付
     */
    static function handleConfirmPay()
    {
        if(empty($_REQUEST['payment_id'])){
            return self::request('error','','确认线下支付参数错误！！');
        }
        $payment = Finance_Payment::getPaymentInfoById($_REQUEST['payment_id']);
        if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
            return self::request('error','','未找到该笔款项，可能已被供应商删除');
        }
        if (!empty($payment['payment_time'])) {
            return self::request('error','','该笔款项已支付!');
        }
        Web_Account::handleIsLogin();;
        //更新订单已支付金额
        $update_data=array(
            'order_price_pay = order_price_pay+?' => $payment['amount'],
        );
        $r =Data_Mysql_Table_Order_Info::update($payment['order_id'], $update_data);
        $r_payment=Data_Mysql_Table_Order_Payment::update(array('payment_id'=>$payment['payment_id']),array('payment_status'=>1));
        if (empty($r[0]) || empty($r_payment[0])){
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }else{
            //更改支付节点的信息
            Finance_Payment::updatePaymentTime($payment['payment_id'],-1);
            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('确认线下支付信息',self::$_orderInfo['id'],'服务方');
            return self::request('success','','确认成功!!');
        }
    }

    /*
     *拒绝线下支付
     */
    static function handleNotConfirmPay()
    {
        $request=Func_Input::filter(array('refuse_reason'=>'string','payment_id'=>'string'));
        if(empty($request['payment_id'])){
            return self::request('error','','确认线下支付参数错误！！');
        }
        if(empty($request['refuse_reason'])){
            return self::request('error','','请输入拒绝原因！！');
        }
        $payment = Finance_Payment::getPaymentInfoById($request['payment_id']);
        if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
            return self::request('error','','未找到该笔款项！！');
        }
        if (!empty($payment['payment_time'])) {
            return self::request('error','','该笔款项已支付!');
        }
        Web_Account::handleIsLogin();;
        $r_payment=Data_Mysql_Table_Order_Payment::update(array('payment_id'=>$payment['payment_id']),array('payment_status'=>2,'refuse_reason'=>$request['refuse_reason']));
        if (empty($r_payment[0])){
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }else{
            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('线下支付信息被拒绝',self::$_orderInfo['id'],'服务方');
            return self::request('success','','操作成功');
        }
    }

    /*
     *@订单审核
     */
    static function handlePending()
    {
        Web_Account::handleAccountHasAuth('审核', 21);
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            return self::request('error','','参数错误1！');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'vendor_account_id' => $_SESSION['user']['id'],
            'create_time2' => time(),
            'order_status' => 5,
        ));
        if (empty($r[0])) {
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }
        //更新档期
        Data_Mysql_Table_Product_Schedule::update(array('order_id' => self::$_orderInfo['id'],), array('status' => 1));
        //审核通过发通知
        Api_Order_Send_Message::sendPendingMsg(self::$_orderInfo['order_no'],self::$_orderInfo['buyer_account_id']);
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('订单审核通过',self::$_orderInfo['id'],'服务方');
        return self::request('success','','操作成功！');
    }

    //订单取消
    static function handleCancel()
    {
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer'] && !self::$_orderInfo['is_vendor']) {
            return self::request('error','','订单取消/拒绝发生异常1，请稍候再试或联系客服人员！！');
        }
        $request=Func_Input::filter(array('reason'=>'string','order_status'=>'int'));
        if(empty($request['order_status'])){
            return self::request('error','','订单取消/拒绝参数异常！！');
        }
        if(empty($request['reason'])){
            return self::request('error','','请填写取消/拒绝理由！！');
        }
        $msg='';
        $operator='';
        switch($request['order_status']){
            case -1:
                $msg='订单已取消！';
                if(self::$_orderInfo['is_buyer']){
                    $operator='采购方';
                }else{
                    $operator='服务方';
                }
                $update_data['order_status']=-1;
                break;
            case 110:
                $msg='取消订单请求已提交，待商户确认！';
                $operator='采购方';
                $reason['buyer_cancel_time']=time();
                break;
            case 115:
                $msg='取消订单请求已提交，待买家确认！';
                $operator='服务方';
                $reason['vendor_cancel_time']=time();
                break;
        }
        if(self::$_orderInfo['is_buyer']){
            $reason['is_buyer']=1;
        }
        if(self::$_orderInfo['is_vendor']){
            $reason['is_vendor']=1;
        }
        $reason['reason']=$request['reason'];
        $update_data['order_close_info']=$reason;
        $update_data['cancel_time']=time();
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], $update_data);
        if (empty($r[0])) {
            return self::request('error','','订单取消发生异常2，请稍候再试或联系客服人员！！');
        }
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('取消订单',self::$_orderInfo['id'],$operator);

        if($request['order_status']==-1){
            //删除档期
            if(!empty(self::$_orderInfo['product_id'])){
                Api_Order_Delete_Schedule::deleteSchedule(self::$_orderInfo['product_id'],'product',self::$_orderInfo['start_time'],self::$_orderInfo['end_time']);
            }elseif(!empty(self::$_orderInfo['product_set_id'])){
                Api_Order_Delete_Schedule::deleteSchedule(self::$_orderInfo['product_set_id'],'set',self::$_orderInfo['start_time'],self::$_orderInfo['end_time']);
            }
        }
        return self::request('success','',$msg);
    }

    //确认订单取消
    static function handleConfirmCancel()
    {
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor'] && !self::$_orderInfo['is_buyer'] )  {
            return self::request('error','','确认订单取消发生异常1，请稍候再试或联系客服人员！！');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => -1,
            'cancel_time' => time(),
        ));
        if (empty($r[0])) {
            return self::request('error','','确认订单取消发生异常2，请稍候再试或联系客服人员！！');
        }
        if(self::$_orderInfo['is_buyer']){
            $operator='采购方';
        }else{
            $operator='服务方';
        }
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('确认取消订单',self::$_orderInfo['id'],$operator);

        //删除档期
        if(!empty(self::$_orderInfo['product_id'])){
            Api_Order_Delete_Schedule::deleteSchedule(self::$_orderInfo['product_id'],'product',self::$_orderInfo['start_time'],self::$_orderInfo['end_time']);
        }elseif(!empty(self::$_orderInfo['product_set_id'])){
            Api_Order_Delete_Schedule::deleteSchedule(self::$_orderInfo['product_set_id'],'set',self::$_orderInfo['start_time'],self::$_orderInfo['end_time']);
        }
        return self::request('success','','订单已取消！');
    }

    //拒绝取消订单
    static function handleRefuseCancel()
    {
        //判断是否是卖家或买家
        if (!self::$_orderInfo['is_vendor'] && !self::$_orderInfo['is_buyer'] )  {
            return self::request('error','','拒绝取消订单发生异常1，请稍候再试或联系客服人员！！');
        }
        $request=Func_Input::filter(array('refuse_cancel_reason'=>'string','order_status'=>'int'));
        if(empty($request['order_status']) && self::$_orderInfo['is_vendor']){
            $request['order_status']=120;
        }
        if(empty($request['order_status']) && self::$_orderInfo['is_buyer']){
            $request['order_status']=125;
        }

        $reason=self::$_orderInfo['order_close_info'];
        if($request['order_status']==120){
            //卖家拒绝取消订单
            $reason['vendor_refuse_time']=time();
        }elseif($request['order_status']=125){
            //买家拒绝取消订单
            $reason['buyer_refuse_time']=time();
        }
//        self::$_orderInfo['order_close_info']['refuse_cancel_reason']=$request['refuse_cancel_reason'];
//        self::$_orderInfo['order_close_info']['refuse_cancel_time']=time();
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
//            'order_status' =>$request['order_status'],
            'order_close_info'=>$reason,
        ));
        if (empty($r[0])) {
            return self::request('error','','拒绝取消订单发生异常2，请稍候再试或联系客服人员！！');
        }
        if(self::$_orderInfo['is_buyer']){
            $operator='采购方';
        }else{
            $operator='服务方';
        }
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('拒绝取消订单',self::$_orderInfo['id'],$operator);

        return self::request('success','','订单取消已拒绝！');
    }


    //订单评价
    static function handleEvaluate()
    {
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer'] && !self::$_orderInfo['is_vendor']) {
            return self::request('error','','评价参数异常！');
        }
        $evaluate=Func_Input::filter(array(
            'quality'=>'string',
            'service'=>'string',
            'speed'=>'string',
            'demo'=>'string',
        ),$_REQUEST);
        $evaluate['order_id']=self::$_orderInfo['id'];
        $evaluate['order_no']=self::$_orderInfo['order_no'];
        if(!empty(self::$_orderInfo['product_id'])){
            $evaluate['product_id']=self::$_orderInfo['product_id'];
        }elseif(!empty(self::$_orderInfo['product_set_id'])){
            $evaluate['set_id']=self::$_orderInfo['product_set_id'];
        }else{
            return self::request('error','','评价参数异常2！');
        }
        $r=Data_Mysql_Table_Order_Evaluate::insert($evaluate);
        if (empty($r[0])) {
            return self::request('error','','评价失败，请稍候再试或联系客服人员！');
        }else{
            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('评价订单',self::$_orderInfo['id'],'采购方');
            return self::request('success','','评价成功！');
        }
    }

    //订单签约，上传合同
    static function handleAddConform(){
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            return self::request('error','','商户上传合同异常！');
        }
        $request=Func_Input::filter(array(
            'conform_title'=>'string',
            'conform_amount'=>'string',
            'conform_path'=>'array',
            'conform_id'=>'int',
        ),$_REQUEST);
        if(!empty($request['conform_path'])){
            unset($request['conform_path']['$$']);
            $data['conform_path']=array_values($request['conform_path']);
        }
        if(empty($request['conform_title']) || empty($request['conform_path'])){
            return self::request('error','','合同名称和合同文件不能为空！');
        }
        if(empty($request['conform_amount']) || !is_numeric($request['conform_amount']) || $request['conform_amount'] < 0){
            return self::request('error','','请输入正确的合同金额！');
        }
        $data['order_id']=self::$_orderInfo['id'];
        $data['order_no']=self::$_orderInfo['order_no'];
        $data['conform_title']=$request['conform_title'];
        $data['conform_amount']=$request['conform_amount'];
        $data['conform_path']=$request['conform_path'];
        $data['status']=0;

        if(empty($request['conform_id'])){
            $rs=Data_Mysql_Table_Order_Conform::insert($data);
        }else{
            $rs=Data_Mysql_Table_Order_Conform::update(array('id'=>$request['conform_id']),$data);
        }
        if(empty($rs[0])){
            return self::request('error','','合同添加/修改失败！！');
        }else{
            //上传合同
            Api_Order_Normal_Api::setTracking('上传合同',self::$_orderInfo['id'],'服务方');
            return self::request('success','','合同上传/修改成功，等待买家确认！');
        }
    }

    //买家拒绝合同
    static function handleRefuseConform(){
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer']) {
            return self::request('error','','采购方拒绝合同异常！');
        }
        $request=Func_Input::filter(array(
            'conform_id'=>'int',
            'refuse_reason'=>'string',
        ),$_REQUEST);
        if(empty($request['conform_id'])){
            return self::request('error','','拒绝合同参数错误！');
        }
        if(empty($request['refuse_reason'])){
            return self::request('error','','请输入拒绝理由！');
        }
        $rs=Data_Mysql_Table_Order_Conform::update(array('id'=>$request['conform_id']),array('status'=>-1,'refuse_reason'=>$request['refuse_reason']));
        if(empty($rs[0])){
            return self::request('error','','拒绝合同失败！！');
        }else{
            //添加订单追踪信息
            Api_Order_Normal_Api::setTracking('拒绝签约',self::$_orderInfo['id'],'采购方');
            return self::request('success','','已成功拒绝合同，等待服务方重新上传');
        }

    }

    //卖家删除合同
    static function handleDeleteConform(){
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            return self::request('error','','服务方删除合同异常！');
        }
        $request=Func_Input::filter(array(
            'conform_title'=>'string',
            'conform_id'=>'int',
        ),$_REQUEST);
        if (empty($request['conform_id'])) {
            return self::request('error','','删除合同参数错误！');
        }

        //删除合同
        $r=Data_Mysql_Table_Order_Conform::delete(array('id'=>$request['conform_id']));

        if (empty($r[0])) {
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }

        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('删除合同【'.$request['conform_title'].'】',self::$_orderInfo['id'],'服务方');
        return self::request('success','','删除合同成功!!');
    }


    //买家签约
    static function handleConformSign(){
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer']) {
            return self::request('error','','采购方签约异常！');
        }
        Web_Account::handleAccountHasAuth('签约', 1);
        $request=Func_Input::filter(array(
            'password2'=>'string',
            'check_code'=>'string',
            'check_type'=>'string',
            'conform_id'=>'int',
            'phone'=>'phone',
        ),$_REQUEST);
        if (empty($request['conform_id'])) {
            return self::request('error','','采购方签约参数错误！');
        }

        if($request['check_type']=='pwd'){
            if (empty($request['password2']) ) {
                return self::request('error','','交易密码必须正确填写！');
            }
            $check_pwd=Api_Order_Info::checkPassword2($request['password2']);
            if(isset($check_pwd['status']) && $check_pwd['status']==0){
                return self::request('error','',$check_pwd['msg']);
            }
        }

        if ($request['check_type']=='code') {
            if(empty($request['check_code']) || empty($request['phone'])){
                return self::request('error','','验证码必须正确填写！');
            }
            $_REQUEST['phone']=$request['phone'];
            $_REQUEST['auth_code']=$request['check_code'];
            $check_code=Api_Common_Check_Auth_Code::checkAuthCode();
            if(isset($check_code['status']) && $check_code['status']==0){
                return self::request('error','',$check_code['msg']);
            }

        }

         //更新合同状态
        $conform_rs=Data_Mysql_Table_Order_Conform::update(array('id'=>$request['conform_id']),array('status'=>1,'refuse_reason'=>''));
        if(empty($conform_rs[0])){
            return self::request('error','','确认合同失败，此合同可能已被供应商删除！');
        }

        //获取合同信息
        $conform=Api_Order_Normal_Api::getConformInfoById($request['conform_id']);

        //更改订单签约时间,订单状态和订单金额
        Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => 12,
            'create_time3'=>time(),
        ));
        //发消息通知供应商买家已签约
        Api_Order_Send_Message::sendBuyerAssignMsg(self::$_orderInfo['order_no'],self::$_orderInfo['vendor_account_id']);
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('签约成功【'.$conform['conform_title'].'】',self::$_orderInfo['id'],'采购方');
        return self::request('success','','签约成功!!');

    }

    //卖家完成订单
    static function handleOrderComplete(){
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            return self::request('error','','操作异常2！');
        }
        $update_data['create_time5']=time();
        $update_data['order_status']=90;
        //更改订单签约时间,订单状态和订单金额
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], $update_data);
        if (empty($r[0])) {
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('卖家完成订单',self::$_orderInfo['id'],'服务方');
        return self::request('success','',"订单完成");
    }

}