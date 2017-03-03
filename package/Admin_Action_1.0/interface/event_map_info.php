<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/21
 * Time: 10:06
 */
switch (Core::$urls['action']){
	case 'getUnsolvedEvent':
		Event_Map_Info_Ctl :: handleGetUnsolvedEvent();
		break;
	case 'storeUnsolvedEvent':
		Event_Map_Info_Ctl :: storeUnsolvedEvent();
		break;
	default:
		break;
}
class Event_Map_Info_Ctl{
	static function handleGetUnsolvedEvent(){
		$data=Data_Mysql_Table_event_Info::select('geo_lat,geo_lng','','',999);
		$i=0;
		foreach($data as $v){
			if($v['geo_lat']!=0&&$v['geo_lat']!=0){
			$i++;
			}
		}
		if($i==0){
			Tpl_Smarty::assign('addr',0);
		}else{
			$count= Data_Mysql_Table_event_Info::select('count(*) as c');
			$start=Data_Mysql_Table_event_Info::select('id','','',$count[0]['c']);
			$conditions=array(
				'id> ?'=>array(
					$start_id=$start[mt_rand(0,$count[0]['c']-10)]['id']
				)
			);
			$data=Data_Mysql_Table_event_Info::select('id,addr,event_name',$conditions,'',10);
			$addr=array();
			foreach($data as $k=>&$v){
				$v['addr']=str_replace(' ','',$v['addr']);
				if($v['addr']){
					$return = file_get_contents("http://api.map.baidu.com/geocoder/v2/?address=上海市".$v['addr']."ak=aaNCRRcGGai6klHMOGZ8yBbP");
					$lat=strstr($return,'<lat>');
					$lat=strtok($lat,'</lat>');
					$lng=strstr($return,'<lng>');
					$lng=strtok($lng,'</lng>');
					$addr[$k]['geo_lat']=$lat;
					$addr[$k]['geo_lng']=$lng;
					$addr[$k]['addr']=$v['addr'];
					$addr[$k]['event_name']=$v['event_name'];
					$addr[$k]['id']=$v['id'];
				}
			}
			Tpl_Smarty::assign('addr',$addr);
			foreach($addr as $k=>&$v){
				$conditions=array(
					'id'=>array($v['id'])
				);
				$v['geo_lat']=$v['geo_lat']*1000;
				$v['geo_lng']=$v['geo_lng']*1000;
				$update=Data_Mysql_Table_Event_Info::update($conditions,$v);
			}
		}
		Tpl_Smarty::display('Admin_Action', 'event_map_info_deal.tpl');
	}

}