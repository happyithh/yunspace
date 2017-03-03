<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/14
 * Time: 20:43
 */

header('content-type:text/html;charset=utf-8');
switch(Core::$urls['action']){
	case '':
		Wechat_Event_Info :: handle();
		break;
}
class Wechat_Event_Info
{
  static function handle(){
	  $count= Data_Mysql_Table_event_Info::select('count(*) as c');
	  $start=Data_Mysql_Table_event_Info::select('id','','',$count[0]['c']);
	  $conditions=array(
		  'id> ?'=>array(
			  $start_id=$start[mt_rand(0,$count[0]['c']-20)]['id']
		  )
	  );
	  $data=Data_Mysql_Table_event_Info::select('id,attr,addr,event_name,attr_index,event_time,logo,geo_lat,geo_lng',$conditions,'',20);
	  foreach($data  as $k=>&$v){
		  if( $v['geo_lng']!=0&&$v['geo_lat']!=0){
			  $v['event_time']=date('Y-m-d H:i',$v['event_time']);
			  $v['attr']=json_decode($v['attr'],true);
			  $v['attr_index']=json_decode($v['attr_index'],true);
			  $v['geo_lat']=$v['geo_lat']/1000;
			  $v['geo_lng']=$v['geo_lng']/1000;
		  }
	  }
	  Tpl_Smarty::assign('_data', $data);
	  Tpl_Smarty::display('Wechat', 'near.tpl');
  }


}