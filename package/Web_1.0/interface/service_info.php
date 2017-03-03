<?php
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
    Func_Header::notFound();
}
$serviceInfo = Web_Product_Info::getInstance();

//如果有对应的百科，则跳转到百科页面 add by yl 2016/06/22
$space_name=$serviceInfo->productInfo['have_space'];
if(empty($space_name)){
	$space_exists=Data_Mysql_Table_Spacepedia::select('id',array('space_name = ?'=>$serviceInfo->productInfo['product_name'],'status'=>1));
	if(!empty($space_exists[0]['id'])){
			$space_name=$serviceInfo->productInfo['product_name'];	
			Data_Mysql_Table_Product_Info::query("update {table} set have_space = ? where id = ?",array($serviceInfo->productInfo['product_name'],$serviceInfo->productInfo['id']));
	}else{
		//判断旧记录中是否存在该名称
		$cols="{table}.id,{prefix}spacepedia.space_name as new_space_name";
		$condition2["{table}.space_name = ?"]=$serviceInfo->productInfo['product_name'];
		$condition2["{prefix}spacepedia.status = ?"]=1;
		$table="{table} LEFT JOIN {prefix}spacepedia ON {table}.space_id = {prefix}spacepedia.id";
		$old_exsits=Data_Mysql_Table_Space_Redirect::select($cols,$condition2,'',1,$table);
		if(!empty($old_exsits[0]['id'])){
			$space_name=$old_exsits[0]['new_space_name'];
			Data_Mysql_Table_Product_Info::query("update {table} set have_space = ? where id = ?",array($space_name,$serviceInfo->productInfo['id']));

		}else{
			//不能跳转的记录
			Core::log("product_to_space", "product_name为：【".$serviceInfo->productInfo['product_name'].'】的场地没有同名且上线的百科！');
		}	
	}
}
if(!empty($space_name)){
	//判断当前场地是否存在且是上线状态
	$space_exists2=Data_Mysql_Table_Spacepedia::select('id',array('space_name = ?'=>$space_name,'status'=>1));
	if(!empty($space_exists2[0]['id'])){
		Header("HTTP/1.1 301 Moved Permanently");
		// Header("Location: http://".Core::$urls['host']."/site/".Func_Url::str_urlencode($space_name,1)); 
		Header("Location: http://www.yunspace.com.cn/site/".Func_Url::str_urlencode($space_name,1)); 
		exit;
	}else{
		//不能跳转的记录
		Core::log("product_to_space", "product_name为：【".$serviceInfo->productInfo['product_name'].'】的场地,有过跳转记录，对应的百科名称为：【'.$space_name.'】,这个百科可能已经改名或者下线');
	}
}

//访问记录跟踪
Web_Account::footPrint($serviceInfo->productInfo);

//输出模板
Data_Config_Site::seo('service_info', $serviceInfo->productInfo);
if($serviceInfo->productInfo['is_space']){
    Tpl_Smarty::assign('nav_index', 1);
}else{
    Tpl_Smarty::assign('nav_index', 2);
}

Web_Product_Info::display('service-info.v2.1.tpl');