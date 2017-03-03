<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/22
 * Time: 11:00
 */
class App_Api_Broker_Event
{
	/*
	 * @step 获取所有活动数据
	 * @step 将活动的相应的状态与数据绑定
	 * @step 以json格式输出活动数据
	 * */
	static function getEventList()
	{
		$activity=Data_Mysql_Table_Event_Info::select('id,event_name,event_time,attr,status','','',10);
		foreach($activity as $k=>&$v){
			switch($v['status']){
				case "0":
					$v['status']="待审核";
					break;
				case "1":
					$v['status']="进行中";
					break;
				case "98":
					$v['status']="停用";
					break;
				case "99":
					$v['status']="已取消";
					break;
			}
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
		}
		echo json_encode($activity);
		die();
	}
	/*
	 * @step 获取相应的ID
	 * @step 根据相应ID获取相应的活动详情以json格式输出
	 * */
	static function getEventInfoById()
	{
		$request = Func_Input::filter(array(
			'event_id' => 'int',
		),$_REQUEST);
		$conditions=array(
			'id'=>$request['event_id']
		);
		$data=Data_Mysql_Table_Event_Info::select("event_name,event_time,addr,logo,attr,media",$conditions);
		foreach($data as $k=>&$v){
			$v['event_time']=date("Y-m-d H:i:s",$v['event_time']);
			$v['attr']=json_decode($v['attr'],true);
			$v['media']=json_decode($v['media'],true);
		}
		echo json_encode($data[0]);
		die();
	}
	/*
	 * 活动筛选
	 * */
	static function getEventDressing()
	{
		//以大于某个时间为准
		if(empty($_REQUEST['event_time2'])&&!empty($_REQUEST['event_time1'])) {
			$conditions=self::getEventMoreStartTime();
		}
		//以小于某个时间为准
		if(empty($_REQUEST['event_time1'])&&!empty($_REQUEST['event_time2'])) {
			$conditions=self::getEventLessEndTime();
		}
		//在某个时间范围内
		if(!empty($_REQUEST['event_time1'])&&!empty($_REQUEST['event_time2'])) {
			$conditions=self::getEventRangeTime();
		}
		//获取筛选活动
		self::getEventDressingData($conditions);
	}
	/*
	 * 以小于某个活动时间为准
	 * */
	static function getEventLessEndTime()
	{
			$time2=explode('-',$_REQUEST['event_time2']);
			$_REQUEST['event_time2']=mktime(0,0,0,$time2[1],$time2[2],$time2[0]);
			$request = Func_Input::filter(array(
				'event_status' => 'int',
				'event_time2'=>'int'
			),$_REQUEST);
			$conditions=array(
				'status'=>$request['event_status'],
				'event_time<=?'=>array($request['event_time2'])
			);
		    return $conditions;
	}
	/*
	 * 以大于某个活动时间为准
	 * */
	static function getEventMoreStartTime()
	{
		$time1=explode('-',$_REQUEST['event_time1']);
		$_REQUEST['event_time1']=mktime(0,0,0,$time1[1],$time1[2],$time1[0]);
		$request = Func_Input::filter(array(
			'event_status' => 'int',
			'event_time1'=>'int'
		),$_REQUEST);
		$conditions=array(
			'status'=>$_REQUEST['event_status'],
			'event_time>=?'=>array($request['event_time1'])
		);
		return $conditions;
	}

	/*
	 * 在活动开始时间跟结束时间内
	 * */
	static function getEventRangeTime()
	{
		$time1=explode('-',$_REQUEST['event_time1']);
		$time2=explode('-',$_REQUEST['event_time2']);
		$_REQUEST['event_time1']=mktime(0,0,0,$time1[1],$time1[2],$time1[0]);
		$_REQUEST['event_time2']=mktime(0,0,0,$time2[1],$time2[2],$time2[0]);
		$request = Func_Input::filter(array(
			'event_status' => 'int',
			'event_time1'=>'int',
			'event_time2'=>'int'
		),$_REQUEST);
		$conditions=array(
			'status'=>$_REQUEST['event_status'],
			'event_time>=? and event_time<=?'=>array($request['event_time1'],$request['event_time2'])
		);
		return $conditions;
	}
	/*
	 * 获取筛选活动
	 * */
	static function getEventDressingData($conditions)
	{
		$activity=Data_Mysql_Table_Event_Info::select('id,event_name,event_time,attr,status',$conditions,'',10);
		foreach($activity as $k=>&$v){
			switch($v['status']){
				case "0":
					$v['status']="待审核";
					break;
				case "1":
					$v['status']="进行中";
					break;
				case "98":
					$v['status']="停用";
					break;
				case "99":
					$v['status']="已取消";
					break;
			}
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
		}
		echo json_encode($activity);
		die();
	}
	/*
	 * 获取更多筛选活动
	 * */
	static function loadMoreEventDressList(){
//		$last_id = $_REQUEST['last_id'];
		switch($_REQUEST['event_status']) {
			case "进行中":
				$_REQUEST['event_status'] = 1;
				break;
			case "停用":
				$_REQUEST['event_status'] = 98;
				break;
			case "已取消":
				$_REQUEST['event_status'] = 99;
				break;
		}
		//以小于某个时间为准
		if(empty($_REQUEST['event_time1'])&&!empty($_REQUEST['event_time2'])) {
 			$conditions=self::getMoreEventDressLessEndTime();
		}
		//以大于某个时间为准
		if(empty($_REQUEST['event_time2'])&&!empty($_REQUEST['event_time1'])){
			$conditions=self::getMoreEventDressMoreStartTime();
		}
		//在某个时间范围内
		if(!empty($_REQUEST['event_time1'])&&!empty($_REQUEST['event_time2'])){
			$conditions=self::getMoreEventDressRangeTime();
		}
		self::getEventDressingData($conditions);
	}
	/*
	 * 以大于某个时间为准
	 * */
	static function getMoreEventDressMoreStartTime()
	{
		$time1=explode('-',$_REQUEST['event_time1']);
		$_REQUEST['event_time1']=mktime(0,0,0,$time1[1],$time1[2],$time1[0]);
		$request = Func_Input::filter(array(
			'event_status' => 'int',
			'event_time1'=>'int',
			'last_id'=>'int'
		),$_REQUEST);
		$conditions=array(
			'status'=>$_REQUEST['event_status'],
			'event_time>=?  and id>?'=>array($request['event_time1'],$request['last_id'])
		);
		return $conditions;
	}
	/*
	 * 以小于某个时间为准
	 * */
	static function getMoreEventDressLessEndTime()
	{
		$time2=explode('-',$_REQUEST['event_time2']);
		$_REQUEST['event_time2']=mktime(0,0,0,$time2[1],$time2[2],$time2[0]);
		$request = Func_Input::filter(array(
			'event_status' => 'int',
			'event_time2'=>'int',
			'last_id'=>'int'
		),$_REQUEST);
		$conditions=array(
			'status'=>$request['event_status'],
			'event_time<=? and id>?'=>array($request['event_time2'],$request['last_id'])
		);
		return $conditions;
	}

	/*
	 * 在某个时间段内的活动
	 * */
	static function getMoreEventDressRangeTime()
	{
		$time1=explode('-',$_REQUEST['event_time1']);
		$time2=explode('-',$_REQUEST['event_time2']);
		$_REQUEST['event_time1']=mktime(0,0,0,$time1[1],$time1[2],$time1[0]);
		$_REQUEST['event_time2']=mktime(0,0,0,$time2[1],$time2[2],$time2[0]);
		$request = Func_Input::filter(array(
			'event_status' => 'int',
			'event_time1'=>'int',
			'event_time2'=>'int',
			'last_id'=>'int'
		),$_REQUEST);
		$conditions=array(
			'status'=>$_REQUEST['event_status'],
			'event_time>=? and event_time<=?  and id>?'=>array($request['event_time1'],$request['event_time2'],$request['last_id'])
		);
		return $conditions;
	}

}