<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/14
 * Time: 20:01
 */
header('content-type:text/html;charset=utf-8');
Data_Config_Site::seo('办活动整体解决方案');
Tpl_Smarty::assign('attr', Data_Config_Vendor_Attr::get('attr'));
Tpl_Smarty::assign('nav_index', 5);

switch(Core::$urls['action']){
	case 'add_demand':
		Act_Demand::addDemand();
		break;
}
$trade=new Data_Config_Vendor_Attr();
$data1=$trade->all['attr']['活动类型'];
$data2=$trade->all['attr']['服务行业'];
$conditions=array(
	'parent_id'=>0
);
$data3=Data_Mysql_Table_Product_Category::select('id,category_name',$conditions,'',9999);
$data4=Data_Mysql_Table_Demand::select('demand');
Tpl_Smarty::assign('_data1',$data1);
Tpl_Smarty::assign('_data2',$data2);
Tpl_Smarty::assign('_data3',$data3);
Tpl_Smarty::display('Wechat', 'demand.tpl');

class Act_Demand{
	static function addDemand(){
		session_start();
		$requests = Func_Input::filter(array(
			'scope'=>'string',
			'date' => 'string',
			'trade'=>'string',
			'services'=>'string',
			'budget'=>'string',
			'account_id'=>'int',
			'demand'=>'string',
		));
		$_REQUEST['demand']=array(
			'活动规模'=>$requests['scope'],
			'活动日期'=>$requests['date'],
			'所属行业'=>$requests['trade'],
			'配套服务'=>$requests['services'],
			'活动预算'=>$requests['budget'],
			'具体要求'=>$requests['demand']
		);
		$_REQUEST['create_time']=time();
		$_REQUEST['ip']=$_SERVER['REMOTE_ADDR'];
		$_REQUEST['account_id']=$_SESSION['user']['id'];
		$request = Func_Input::filter(array(
			'phone'=>'phone',
			'demand' => 'array',
			'demand_type'=>'string',
			'demand_name'=>'string',
			'ip'=>'string',
			'account_id'=>'int',
			'city'=>'string'
		));
		if($request['phone']==''||$request['demand_name']==''){
			Func_Header::back('联系人必须填写或联系号码格式不正确！！');
		}
		$insert=Data_Mysql_Table_Demand::insert($request);
        if(Func_Input::isLocal()){
            $url_host = 'yun.bb';
        }else{
            $url_host = "master.yunspace.com.cn";
        }
        $url = "http://".$url_host."/static/api/message/remote/send.json?demand_id=".$insert[0]."&token=".md5(date('YmdH').'demand_msg');
        @Func_Http::get($url);
		if($insert){
			Func_Header::back('需求已提交，正在审核......');
		}
	}
}