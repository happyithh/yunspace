<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/21
 * Time: 16:12
 */
class App_Api_Broker_Order
{
	/*
	 * 用户订单列表
	 * @step 对传过来的参数进行过滤
	 * @step 设置查询条件
	 * @step 查询相应条件的订单数据
	 * @step 将相应条件的订单状态放入数据数组
	 * @step 将数据返回显示到模板
	 * */
	static function getUserOrderList()
	{
		$request = Func_Input::filter(array(                       //字段过滤，防止意外输入
			'user_id' => 'int',
		),$_REQUEST);
		$condition = array(
			'deal_account_id'=>$request['user_id'],
			'order_status >=0'
		);
		$status = Data_Mysql_Table_Order_Info::$order_status_tpl;
		$rs = Data_Mysql_Table_Order_Info::select('order_no,update_time,id,order_title,order_status,vendor_account_id',$condition,'ORDER BY id DESC',15);
		$data = array();
		if($rs){
			$data = $rs;
			foreach($data as $k=>$v){
				$data[$k]['order_status_text'] = $status[$data[$k]['order_status']];
				$data[$k]['update_time'] = date("Y-m-d h:i:s", $data[$k]['update_time']);
			}
		}
//        $data['order_detail'] = json_decode($data['order_detail']);
		$result = json_encode($data);                               //输出json格式的数据
		echo $result;
	}
	/*
	 * 加载更多订单
	 * @step 获取当前的登陆用户信息的ID和查询出来结果的最后的id
	 * @step 设置查询条件
	 * @step 查询数据
	 * @step 获取订单相应的订单的状态
	 * @step 以json格式输出模板
	 * */
	static function getLoadMoreOrderList()
	{
		$user_id = $_REQUEST['user_id'];
		$last_id = $_REQUEST['last_id'];
		$condition = array(
			'deal_account_id'=>$user_id,
			'order_status >=0',
			'id < ?'=>$last_id
		);
		$status = Data_Mysql_Table_Order_Info::$order_status_tpl;
		$rs = Data_Mysql_Table_Order_Info::select('order_no,update_time,id,order_title,order_status,vendor_account_id',$condition,'ORDER BY id DESC',10);
		$data = array();
		if($rs){
			$data = $rs;
			foreach($data as $k=>$v){
				$data[$k]['order_status'] = $status[$data[$k]['order_status']];
				$data[$k]['update_time'] = date("Y-m-d h:i:s", $data[$k]['update_time']);
			}
		}

		$result = json_encode($data);
		echo $result;
	}
	/*
	 * 订单详情
	 * @step 获取相应的订单ID
	 * @step 根据相应的订单ID获取该订单数据
	 * @step 得到相应的订单状态
	 * @step 获取订单用户的号码跟姓名
	 * @step 输出json格式的订单详情数据
	 * */
	static function getOrderInfoById()
	{
		$order_id = $_REQUEST['order_id'];
		$status = Data_Mysql_Table_Order_Info::$order_status_tpl;
		$rs = Data_Mysql_Table_Order_Info::select('order_no,order_title,start_time,order_status,buyer_account_id,create_time',array('id'=>$order_id));
		$rs[0]['order_status_text'] = $status[$rs[0]['order_status']];
		$rs[0]['start_time'] = date("Y-m-d h:i:s", $rs[0]['create_time']);
		$rs2 = Data_Mysql_Table_Account::select('phone,username',array('id'=>$rs[0]['buyer_account_id']));
		$data = array_merge($rs[0], $rs2[0]);
		$result = json_encode($data);
		echo $result;
	}
	/*
	 * 订单筛选
	 *
	 * */
	static function getOrderDressing()
	{
		//结束时间为准
		if(empty($_REQUEST['start_time'])&&!empty($_REQUEST['end_time'])) {
			$condition=self::getConditionLessEndTime();
		}
		//以开始时间为准
		if(empty($_REQUEST['end_time'])&&!empty($_REQUEST['start_time'])) {
			$condition=self::getConditionMoreStartTime();
		}
		//开始时间、结束时间都不为空
		if(!empty($_REQUEST['start_time'])&&!empty($_REQUEST['end_time'])) {
			$condition=self::getConditionRangeTime();
		}
		//获取数据
       self::getDressingData($condition);
	}
	/*
	 * 订单时间大于某个时间
	 * */
	static function  getConditionMoreStartTime()
	{

		$time1 = explode('-', $_REQUEST['start_time']);
		$_REQUEST['start_time'] = mktime(0, 0, 0, $time1[1], $time1[2], $time1[0]);

		$request = Func_Input::filter(array(
			'user_id' => 'int',
			'status'=>'int',
			'start_time'=>'int'
		),$_REQUEST);
		$condition=array(
//			'order_status'=>$request['status'],
			'(start_time >= ? and buyer_account_id = ?)'=>array($request['start_time'],$request['user_id'])
		);
		return $condition;
	}
	/*
	 * 以结束时间为准
	 * */
	static function getConditionLessEndTime()
	{
		$time2=explode('-',$_REQUEST['end_time']);
		$_REQUEST['end_time']=mktime(0,0,0,$time2[1],$time2[2],$time2[0]);
		$request = Func_Input::filter(array(
			'user_id' => 'int',
			'status'=>'int',
			'end_time'=>'int'
		),$_REQUEST);
//		$request['end_time']=60*60*24+$request['end_time'];
		$condition=array(
			'order_status'=>$request['status'],
			'end_time<=? and buyer_account_id=?'=>array($request['end_time'],$request['user_id'])
		);
		return $condition;
	}
	/*
	 * 在开始时间到结束时间的范围
	 * */
	static function getConditionRangeTime()
	{
		$time1 = explode('-', $_REQUEST['start_time']);
		$time2 = explode('-', $_REQUEST['end_time']);
		$_REQUEST['start_time'] = mktime(0, 0, 0, $time1[1], $time1[2], $time1[0]);
		$_REQUEST['end_time'] = mktime(0, 0, 0, $time2[1], $time2[2], $time2[0]);
		$request = Func_Input::filter(array(
			'user_id' => 'int',
			'status' => 'int',
			'start_time' => 'int',
			'end_time' => 'int'
		), $_REQUEST);
		$request['end_time']=60*60*24+$request['end_time'];
		$condition = array(
			'order_status'=>$request['status'],
			'start_time>=? and end_time<=? and buyer_account_id=?'=>array($request['start_time'],$request['end_time'],$request['user_id'])
		);
		return $condition;
	}
	/*
	 * 获取筛选结果
	 * */
	static function getDressingData($condition)
	{
		$status = Data_Mysql_Table_Order_Info::$order_status_tpl;
		$rs = Data_Mysql_Table_Order_Info::select('order_no,update_time,id,order_title,order_status,vendor_account_id',$condition,'ORDER BY id DESC',10);
		$data = array();
		if($rs){
			$data = $rs;
			foreach($data as $k=>$v){
				$data[$k]['order_status_text'] = $status[$data[$k]['order_status']];
				$data[$k]['update_time'] = date("Y-m-d h:i:s", $data[$k]['update_time']);
			}
		}
		$result = json_encode($data);
		echo $result;
	}

	//加载更多筛选订单
	static function loadMoreOrderDressList(){
		Core::outPut('');
		switch($_REQUEST['status']) {
			case "预定":
				$_REQUEST['status'] = 0;
				break;
			case "审核通过":
				$_REQUEST['status'] = 5;
				break;
			case "审核未通过":
				$_REQUEST['status'] = 6;
				break;
			case "买家签约":
				$_REQUEST['status'] = 12;
				break;
			case "买家付款":
				$_REQUEST['status'] = 15;
				break;
			case "待结算":
				$_REQUEST['status'] = 20;
				break;
			case "订单完成":
				$_REQUEST['status'] = 90;
				break;
			case "订单结算完成":
				$_REQUEST['status'] = 91;
				break;
		}
		//结束时间为准
		if(empty($_REQUEST['start_time'])&&!empty($_REQUEST['end_time'])) {
			$condition=self::getMoreEventDressLessEndTime();
		}
		//以开始时间为准
		if(empty($_REQUEST['end_time'])&&!empty($_REQUEST['start_time'])) {
			$condition=self::getMoreEventDressMoreStartTime();
		}
		//开始时间、结束时间都不为空
		if(!empty($_REQUEST['start_time'])&&!empty($_REQUEST['end_time'])) {
			$condition=self::getMoreEventDressRangeTime();
		}
		$status = Data_Mysql_Table_Order_Info::$order_status_tpl;
		$rs = Data_Mysql_Table_Order_Info::select('order_no,update_time,id,order_title,order_status,vendor_account_id',$condition,'ORDER BY id DESC',10);
		$data = array();
		if($rs){
			$data = $rs;
			foreach($data as $k=>$v){
				$data[$k]['order_status_text'] = $status[$data[$k]['order_status']];
				$data[$k]['update_time'] = date("Y-m-d h:i:s", $data[$k]['update_time']);
			}
		}
		$result = json_encode($data);
		echo $result;
	}
	/*
	 * 加载更多以结束时间为准活动
	 * */
	static function getMoreEventDressLessEndTime()
	{
		$time2=explode('-',$_REQUEST['end_time']);
		$_REQUEST['end_time']=mktime(0,0,0,$time2[1],$time2[2],$time2[0]);
		$request = Func_Input::filter(array(
			'user_id' => 'int',
			'status'=>'int',
			'end_time'=>'int',
			'last_id'=>'int'
		),$_REQUEST);
		$request['end_time']=60*60*24+$request['end_time'];
		$condition=array(
			'order_status'=>$request['status'],
			'end_time<=? and buyer_account_id=? and id<?'=>array($request['end_time'],$request['user_id'],$request['last_id'])
		);
		return $condition;
	}
	/*
	 * 加载更多以开始时间为准的活动
	 **/
	 static function getMoreEventDressMoreStartTime()
	 {
		 $time1 = explode('-', $_REQUEST['start_time']);
		 $_REQUEST['start_time'] = mktime(0, 0, 0, $time1[1], $time1[2], $time1[0]);
		 $request = Func_Input::filter(array(
			 'user_id' => 'int',
			 'status'=>'int',
			 'start_time'=>'int',
			 'last_id'=>'int'
		 ),$_REQUEST);
		 $condition=array(
			 'order_status'=>$request['status'],
			 'start_time>=? and buyer_account_id=?  and id<?'=>array($request['start_time'],$request['user_id'],$request['last_id'])
		 );
		 return $condition;
	 }
	/*
	 * 加载更多在活动时间范围内的活动
	 * */
	static function getMoreEventDressRangeTime()
	{
		$time1 = explode('-', $_REQUEST['start_time']);
		$time2 = explode('-', $_REQUEST['end_time']);
		$_REQUEST['start_time'] = mktime(0, 0, 0, $time1[1], $time1[2], $time1[0]);
		$_REQUEST['end_time'] = mktime(0, 0, 0, $time2[1], $time2[2], $time2[0]);
		$request = Func_Input::filter(array(
			'user_id' => 'int',
			'status' => 'int',
			'start_time' => 'int',
			'end_time' => 'int',
			'last_id'=>'int'
		), $_REQUEST);
		$request['end_time']=60*60*24+$request['end_time'];
		$condition = array(
			'order_status'=>$request['status'],
			'start_time>=? and end_time<=? and buyer_account_id=?  and id<?'=>array($request['start_time'],$request['end_time'],$request['user_id'],$request['last_id'])
		);
		return $condition;
	}


}