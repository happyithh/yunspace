<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/6
 * Time: 17:52
 */
class Web_User_Center_Services extends Base
{
	static function handle()
	{
        $action=empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action){
            case 'list':
                self::demandRecommendList();
                break;
            case 'detail':
                if(empty($_REQUEST['demand_id'])){
                    Func_Header::notFound();
                }
                //判断用户是否有查看该服务推荐的权限
                $rs=Data_Mysql_Table_Demand::select('count(*) as c',array('id'=>$_REQUEST['demand_id'],'account_id'=>$_SESSION['user']['id']));
                if($rs[0]['c']<1){
                    Func_Header::notFound();
                }
                if(!empty($_REQUEST['recommend_type']) && $_REQUEST['recommend_type']=='product'){
                    self::demandRecommendDetail();
                }elseif(!empty($_REQUEST['recommend_type']) && $_REQUEST['recommend_type']=='set'){
                    self::demandRecommendSetDetail();
                }
                break;
            case 'pdf':
                self::handlePdf();
                break;
            case 'pdf_set':
                Web_User_Center_Collection::printPdf();
                break;
            case 'cancel':
                self::demandCancel();
                break;
            default:
                self::demandRecommendList();
                break;

        }
    }
    static function demandRecommendList(){

        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "waiting";

        $conditions['account_id']=$_SESSION['user']['id'];
        //获取所有未处理需求
        switch ($type) {
            case 'waiting': $conditions['demand_status'] ='0';
                break;
            case 'done':
                $conditions['demand_status']='1';
//                $conditions[] = 'create_time > '. (time() - (60 * 60 * 24 * 7));
                break;
            case'abandon':
                $conditions['demand_status']='-1';
//                $conditions[] = 'create_time > '. (time()- (60 * 60 * 24 * 7));
                break;
            default : $condition['demand_status'] ='0';
                break;
        }
		$data= Data_Mysql_Table_Demand::page(0,0,'id,demand,demand_status,create_time',$conditions,'ORDER BY create_time desc');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $key=>$value){
                if(!empty($value['demand'])){
                    $data['rows'][$key]['demand']=json_decode($value['demand'],1);
                }
            }
        }

        Tpl_Smarty::assign('type', $type);
		Tpl_Smarty::assign('data',$data);
      	Tpl_Smarty::display('Web_User_Center', 'services/user_admin_services.tpl');
	}
    //  取消
    static  function demandCancel(){
        $request = Func_Input::filter(array(
         'demand_id'=>'int'
        ));
        if(empty($request['demand_id'])){
            Func_Header::back('请稍后重试！');
        }
        $condition['id']  = $request['demand_id'];
        $conditions['account_id'] = $_SESSION['user']['id'];

        $data['demand_status'] = '-1';

        $rs = Data_Mysql_Table_demand::update($condition,$data);

        if($rs[0] == 1){
            Func_Header::to(' 取消成功！','?');
        }else{
            Func_Header::to('取消失败，请重试！','?');
        }
    }
    /*
     * 获取产品推荐列表
     */
	static function demandRecommendDetail(){
        if(!empty($_REQUEST['category'])){
            $categoryId=Data_Config_Site::$staticConfig['space_id'];
            $children = Data_Mysql_Table_Product_Category::getChildren($categoryId);
            $children[] = $categoryId;
            if($_REQUEST['category']=='space'){
                $conditions[] = 'category_id in (' . implode(',', $children) . ')';
            }else if($_REQUEST['category']=='service'){
                $conditions[] = 'category_id not in (' . implode(',', $children) . ')';
            }
        }
        if (!empty($_REQUEST['product_name'])) {
                $conditions['product_name'] = $_REQUEST['product_name'];
        }
        $conditions['{prefix}demand_recommend.demand_id = ?' ]=$_REQUEST['demand_id'];

        $cols=array(
            '{table}.id','{table}.product_name','{table}.category_id','{table}.product_size','{table}.media',
            '{table}.attr','{table}.addr','{table}.price','{prefix}demand_recommend.create_time','{prefix}demand_recommend.demo'
        );
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        //没有推荐的产品和套餐
        $demand_demo=Data_Mysql_Table_Demand_Recommend::select('demand_id,product_id,demo',array('demand_id'=>$_REQUEST['demand_id'],'product_id'=>0,'set_id'=>0));
        if(!empty($demand_demo)){
            $data['demand_recommend_demo']=$demand_demo;
        }
        //获取需求的推荐产品列表
        $conditions['status '] = 1;
        $demand_product = Data_Mysql_Table_Product_Info::page(0,0,$cols,$conditions, 'ORDER BY {prefix}demand_recommend.create_time desc', '
        {table} LEFT JOIN {prefix}demand_recommend on {table}.id={prefix}demand_recommend.product_id');

        if(!empty($demand_product['rows'])){
            foreach($demand_product['rows'] as $key=>$value){
                $demand_product['rows'][$key]['attr']=json_decode($value['attr'],1);
                if (!empty($categories[$value['category_id']][0])) {
                    $demand_product['rows'][$key]['category_name'] = $categories[$value['category_id']][0];
                }
                if(!empty($value['media'])){
                    $demand_product['rows'][$key]['media']=json_decode($value['media'],1);
                    foreach ($demand_product['rows'][$key]['media'] as $mk => $mv) {
                        //主图
                        if (empty($demand_product['rows'][$key]['logo'])) {
                            $demand_product['rows'][$key]['logo'] = $mv['path'];
                        }
                        $mvTags = explode(',', $mv['tags']);
                        foreach ($mvTags as $mTag) {
                            if ($mTag == '@主图') {
                                $demand_product['rows'][$key]['logo'] = $mv['path'];
                            }
                            $demand_product['rows'][$key]['media'][$mTag][$mv['path']] = $mv['name'];
                        }
                    }
                }
            }
        }
        if(!empty($demand_product)){
            $data['demand_recommend_product']=$demand_product;
        }
        Tpl_Smarty::assign('data',$data);
		 Tpl_Smarty::display('Web_User_Center', 'services/user_admin_services_details.tpl');

	}
    /*
    * 获取套餐推荐列表
    */
    static function demandRecommendSetDetail(){
        $request=Func_Input::filter(array(
            'category_id'=>'int',
            'set_name'=>'string',
            'demand_id'=>'int',
        ));
        if(!empty($_REQUEST['category_id'])){
             $conditions['category_id'] = $_REQUEST['category_id'];
        }
        if (!empty($_REQUEST['set_name'])) {
            $conditions['set_name'] = $_REQUEST['set_name'];
        }
        $conditions['{prefix}demand_recommend.demand_id = ?' ]=$_REQUEST['demand_id'];

        $cols=array(
            '{table}.id','{table}.set_name','{table}.category_id','{table}.media',
            '{table}.attr_index','{table}.addr','{table}.detail','{prefix}demand_recommend.create_time','{prefix}demand_recommend.demo'
        );
        //没有推荐的产品和套餐
        $demand_demo=Data_Mysql_Table_Demand_Recommend::select('demand_id,product_id,demo',array('demand_id'=>$_REQUEST['demand_id'],'product_id'=>0,'set_id'=>0));
        if(!empty($demand_demo)){
            $data['demand_recommend_demo']=$demand_demo;
        }
        //获取需求的推荐产品列表
        $conditions['status '] = 1;
        $demand_set = Data_Mysql_Table_Product_Set::page(0,0,$cols,$conditions, 'ORDER BY {prefix}demand_recommend.create_time desc', '
        {table} LEFT JOIN {prefix}demand_recommend on {table}.id={prefix}demand_recommend.set_id');
        $categories=Data_Mysql_Table_Product_Set::$category_name;
        if(!empty($demand_set['rows'])){
            foreach($demand_set['rows'] as $key=>$value){
                $demand_set['rows'][$key]['attr_index']=json_decode($value['attr_index'],1);
                $demand_set['rows'][$key]['detail']=json_decode($value['detail'],1);
                $demand_set['rows'][$key]['category_name'] = $categories[$value['category_id']];
                if(!empty($value['media'])){
                    $demand_set['rows'][$key]['media']=json_decode($value['media'],1);
                    foreach ($demand_set['rows'][$key]['media'] as $mk => $mv) {
                        //主图
                        if (empty($demand_set['rows'][$key]['logo'])) {
                            $demand_set['rows'][$key]['logo'] = $mv['path'];
                        }
                        $mvTags = explode(',', $mv['tags']);
                        foreach ($mvTags as $mTag) {
                            if ($mTag == '@主图') {
                                $demand_set['rows'][$key]['logo'] = $mv['path'];
                            }
                            $demand_set['rows'][$key]['media'][$mTag][$mv['path']] = $mv['name'];
                        }
                    }
                }
            }
        }
        if(!empty($demand_set)){
            $data['demand_recommend_set']=$demand_set;
        }
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('_categories', $categories);
        Tpl_Smarty::display('Web_User_Center', 'services/user_admin_services_set_details.tpl');

    }

    static function handlePdf(){
        if(empty($_REQUEST['product_id'])){
            Func_Header::notFound();
        }
        Web_User_Center_Pdf::handleProductPdf($_REQUEST['product_id']);
    }
}
