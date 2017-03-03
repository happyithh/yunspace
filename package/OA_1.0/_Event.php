<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/29
 * Time: 18:38
 */
class OA_Event  extends Base
{
	static function handle($accountType = 1)
	{

		$_REQUEST['action']=empty($_REQUEST['action'])?'normal':$_REQUEST['action'];
			switch($_REQUEST['action']) {
			case 'normal':
					self::handleNormal();
					break;
			case 'listUnaccepted':
				self::handleUnaccepted();
				break;
			case 'listStop':
				self::handleStop();
				break;
			case 'listDelete':
				self::handleDelete();
				break;
			case 'edit':
				self::handleEdit();
				break;
			case 'update':
				self::updateEvent();
				break;
			case 'accept':
				self::acceptStartEvent();
				break;
			case 'del':
				self::deleteEvent();
				break;
			case 'stop':
				self::stopEvent();
				break;
			case 'start':
				self::acceptStartEvent();
				break;
			case 'downright':
				self::downrightEvent();
				break;
			case 'delete_img':
				self::deleteImg();
				break;
			}

	}


	//正常活动
	static  function handleNormal()
	{

        if(isset($_REQUEST['search']['title'])){
            $_REQUEST['search']['title']=trim($_REQUEST['search']['title']);
            if(!empty($_REQUEST['search']['title'])){
                $conditions = self::handleSearch();
                $sea_url = '&search[title]='.$_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['status']=1;
        //q($conditions);
		$data=Data_Mysql_Table_Event_Info::page(0,10,'id,event_name,event_time,addr,attr,des,status',$conditions, 'ORDER BY id DESC');
		foreach($data['rows'] as $k=>&$v){
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
		}
		Tpl_Smarty::assign('_data',$data);
		Tpl_Smarty::assign('page_nav','normal');
		Tpl_Smarty::display("OA", "event_info_list.tpl");
	}

	//未审核活动
	static function handleUnaccepted()
	{
        if(isset($_REQUEST['search']['title'])){
            $_REQUEST['search']['title']=trim($_REQUEST['search']['title']);
            if(!empty($_REQUEST['search']['title'])){
                $conditions = self::handleSearch();
                $sea_url = '&search[title]='.$_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['status']=0;
		$data=Data_Mysql_Table_Event_Info::page(0,10,'id,event_name,event_time,addr,attr,des,status',$conditions);
		foreach($data['rows'] as $k=>&$v){
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
		}
		Tpl_Smarty::assign('_data',$data);
		Tpl_Smarty::assign('page_nav','notYet');
		Tpl_Smarty::display("OA", "event_info_list.tpl");
	}

	//已停用活动
	static function handleStop()
	{
        if(isset($_REQUEST['search']['title'])){
            $_REQUEST['search']['title']=trim($_REQUEST['search']['title']);
            if(!empty($_REQUEST['search']['title'])){
                $conditions = self::handleSearch();
                $sea_url = '&search[title]='.$_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['status']=98;
		$data=Data_Mysql_Table_Event_Info::page(0,10,'id,event_name,event_time,addr,attr,des,status',$conditions);
		foreach($data['rows'] as $k=>&$v){
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
		}
		Tpl_Smarty::assign('_data',$data);
		Tpl_Smarty::assign('page_nav','stop');
		Tpl_Smarty::display("OA", "event_info_list.tpl");
	}

	//已删除活动
	static function handleDelete()
	{
        if(isset($_REQUEST['search']['title'])){
            $_REQUEST['search']['title']=trim($_REQUEST['search']['title']);
            if(!empty($_REQUEST['search']['title'])){
                $conditions = self::handleSearch();
                $sea_url = '&search[title]='.$_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['status']=99;
		$data=Data_Mysql_Table_Event_Info::page(0,10,'id,event_name,event_time,addr,attr,des,status',$conditions);
		foreach($data['rows'] as $k=>&$v){
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
		}
		Tpl_Smarty::assign('_data',$data);
		Tpl_Smarty::assign('page_nav','delete');
		Tpl_Smarty::display("OA", "event_info_list.tpl");
	}


	//编辑
	static function handleEdit(){
		$request = Func_Input::filter(array(
			'action' => 'string',
			'ids'=>'array'
		));
		if(!$request['action']){
			die("参数错误！！");
		}
		if(!$request['ids']){
			die("参数错误！！");
		}
		$conditions=array(
			'id'=>$request['ids'][0],
		);
		$data=Data_Mysql_Table_Event_Info::select('id,event_name,event_time,addr,attr,des,media,logo',$conditions);

		foreach($data as $k=>&$v){
			$v['attr']=json_decode($v['attr'],true);
			$v['event_time']=date('Y-m-d H:i:s',$v['event_time']);
			$v['media']=json_decode($v['media'],true);
		}
		Tpl_Smarty::assign('city',$_REQUEST['cities']);
		Tpl_Smarty::assign('_data',$data);
		Tpl_Smarty::display("OA", "event_info_edit.tpl");
	}

	//更新活动
	static function updateEvent(){
		$request = Func_Input::filter(array(
			'id'=>'int',
			'event_name' => 'string',
			'event_time'=>'string',
			'addr'=>'string',
			'attr'=>'array',
			'data'=>array('media'=>"array")
		));
		if(!$request['event_name']){
			die('必须填写活动名称！！');
		}
		if(!$request['event_time']){
			die('必须填写活动时间！！');
		}
		if(!$request['attr']){
			die('标签不能为空！！');
		}
		if(!$request['addr']){
			die('地址不能为空！！');
		}
		$conditions=array(
			'id'=>$request['id']
		);
		$request['media']=$request['data']['media'];
		unset($request['data']);
		$request['des']=$_REQUEST['des'];
		$arr=explode(' ',$request['event_time']);
		$date=explode('-',$arr[0]);
		$str_time=mktime($arr[1],0,0,$date[1],$date[2],$date[0]);
		$request['event_time']=$str_time;
		$request['update_time']=time();
		$update=Data_Mysql_Table_Event_Info::update($conditions,$request);
		if($update){
			Func_Header::back('活动信息已更新！！');
		}
	}

	//删除活动
	static function deleteEvent()
	{
		$request = Func_Input::filter(array(
			'action' => 'string',
			'ids'=>'array'
		));
		if(!$request['action']){
			die("参数错误！！");
		}
		if(!$request['ids']){
			die("参数错误！！");
		}
		$conditions=array(
			'id'=>$request['ids'][0]
		);
		$data=array(
			'status'=>99
		);
		$update=Data_Mysql_Table_Event_Info::update($conditions,$data);
		if($update){
			Func_Header::back('删除成功！！');
		}
	}

	//停用活动
	static function stopEvent()
	{
		$request = Func_Input::filter(array(
			'action' => 'string',
			'ids'=>'array'
		));
		if(!$request['action']){
			die("参数错误！！");
		}
		if(!$request['ids']){
			die("参数错误！！");
		}
		$conditions=array(
			'id'=>$request['ids'][0]
		);
		$data=array(
			'status'=>98
		);
		$update=Data_Mysql_Table_Event_Info::update($conditions,$data);
		if($update){
			Func_Header::back('停用成功！！');
		}
	}

	//审核通过,启用，恢复活动
	static function acceptStartEvent()
	{
		$request = Func_Input::filter(array(
			'action' => 'string',
			'ids'=>'array'
		));
		if(!$request['action']){
			die("参数错误！！");
		}
		if(!$request['ids']){
			die("参数错误！！");
		}
		$conditions=array(
			'id'=>$request['ids'][0]
		);
		$data=array(
			'status'=>1
		);
		$update=Data_Mysql_Table_Event_Info::update($conditions,$data);
		if($update){
			Func_Header::back('操作成功！！');
		}
	}

	//彻底删除活动
	static function downrightEvent()
	{
		$request = Func_Input::filter(array(
			'action' => 'string',
			'ids'=>'array'
		));
		if(!$request['action']){
			die("参数错误！！");
		}
		if(!$request['ids']){
			die("参数错误！！");
		}
		$conditions=array(
			'id'=>$request['ids'][0]
		);
		$data=array(
			'status'=>-1
		);
		$update=Data_Mysql_Table_Event_Info::update($conditions,$data);
		if($update){
			Func_Header::back('删除成功！！');
		}
	}
    static function handleSearch(){
            $_REQUEST['title']=$_REQUEST['search']['title'];
            $request = Func_Input::filter(array(
                'title' => 'string',
            ));
            if(!$request['title']){

                Func_Header::back('参数错误！');
            }
            $conditions=array(
                "id=? or event_name=?"=>array($request['title'],$request['title'])
            );
        return $conditions;
        }


}