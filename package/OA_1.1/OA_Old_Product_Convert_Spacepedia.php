<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-16
 * Time: 下午2:06
 */
class OA_Old_Product_Convert_Spacepedia{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getNotConvertList();
                break;
            case "convert":
                self::convertProduct();
                break;
            case "abandon_recover":
                self::abandonConvertProduct();
                break;
            case "is_submit":
                self::submitSpacepediaInfo();
                break;
//            case "add_item_submit":
//                self::addItemSubmit();
//                break;
            default:
                Func_Header::notFound();
                break;
        }
    }
    //获取未转换列表
    static function getNotConvertList(){
        $conditions = array();
        $_COOKIE['search_city']=empty($_COOKIE['search_city'])?"":$_COOKIE['search_city'];
        if(isset($_REQUEST['search']) && empty($_REQUEST['search']['city'])){
            $_COOKIE['search_city']="";
        }else{
            $_REQUEST['search']['city']=empty($_REQUEST['search']['city'])?$_COOKIE['search_city']:$_REQUEST['search']['city'];
        }
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'title'=>'string',
                'category_id' => 'int',
                'city'=>'string',
            ),$_REQUEST['search']);
        }
        //筛选条件
        if (!empty($search)) {
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['product_name'] = $search['title'];
                }
            }
            //城市筛选
            if (!empty($search['city'])) {
                $conditions['attr_new'][46] = "+".$search['city'];
                setcookie('search_city', $search['city'], 0, '/');
            }
            //服务分类筛选
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Product_Category::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = 'category_id in (' . implode(',', $children) . ')';
            }
        }

        $handle_type = empty($_REQUEST['handle_type']) ? 'online' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "online":
                $conditions['is_convert']=0;
                break;
            case "convert":
                $conditions['is_convert']=1;
                break;
            case "abandon":
                $conditions['is_convert']=-1;
                break;
        }
        $children = Data_Mysql_Table_Product_Category::getChildren(Data_Config_Site::$staticConfig['space_id']);
        $children[] = Data_Config_Site::$staticConfig['space_id'];
        $conditions[] = 'category_id in (' . implode(',', $children) . ')';
//        $conditions['status'] = 1;
//        $product = Data_Mysql_Table_Product_Info::page(0, 20, '*', $conditions, 'ORDER BY update_time DESC');
        $product = Data_Mysql_Table_Product_Info::subTable("_update")->page(0, 20, '*', $conditions, 'ORDER BY update_time DESC');
        if (!empty($product['rows'])) {
            foreach ($product['rows'] as $k => $v) {
                $product['rows'][$k]['attr_new'] = json_decode($v['attr_new'], 1);
            }
        }
        $product['other']=array();
        if (!empty($search)) {
            $sea_url = '&search[title]='.$search['title'].'&search[category_id]='.$search['category_id'].'&search[city]='.$search['city'];
            $product['other']['urls'] =  $sea_url;
        }
        $product['other']['categoryList']= Data_Mysql_Table_Product_Category::getTreeCache();
        $product['other']['_category'] =Data_Mysql_Table_Product_Category::getInfoCache();
        $product['other']['handle_type'] =$handle_type;
        Tpl_Smarty::assign('_data',$product);
        Tpl_Smarty::display('OA_Static',"spacepedia/old_product_list.tpl");
    }

    //展示转换为百科或子空间的表单
    static function convertProduct(){
        $request=Func_Input::filter(array(
            'space_name'=>'string',
            'id'=>'int',
        ));
        //获取所有标签
        $_REQUEST['search_type']=2;
        $tag_value=array();
        $tag_result = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
        if(!empty($tag_result['data'])){
            foreach($tag_result['data'] as $k=>$v){
                $tag_value[]=$v['tag_value'];
            }
        }
        Tpl_Smarty::assign('tag_value',$tag_value);
        //获取当前场地的信息
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数缺失！');
        }
        $condition["{table}.id = ?"]=$_REQUEST['id'];
        $data=Data_Mysql_Table_Product_Info::subTable("_update")->select("{table}.*,{prefix}vendor_info_update.vendor_name",$condition,"",1,"{table} LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id = {prefix}vendor_info_update.id");
        if(empty($data[0])){
            Func_Header::back("数据不存在！！");
        }
        $data[0]['attr_new']=json_decode($data[0]['attr_new'],1);
        $data[0]['media']=json_decode($data[0]['media'],1);
        $data[0]['price']=abs($data[0]['price']/100);

        $vendor_info = Data_Config_Vendor_Attr::all();
        $contacts_city = $vendor_info['attr']['城市'];
        Tpl_Smarty::assign('_contacts_city', $contacts_city);
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        if (!empty($data[0]['category_id'])) {
            Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($data[0]['category_id']));
        }


        //判断当前百科是否已存在
        if(strpos($request['space_name'],']')){
            $request['space_name']=trim(substr($request['space_name'],strpos($request['space_name'],']')+1));
        }
        $spacepedia=Api_Spacepedia_List_And_Info::getSpacepediaInfoByName($request['space_name']);
        if(empty($spacepedia)){
            $spacepedia['space_name']=$request['space_name'];
            // $spacepedia['vendor_name']=$data[0]['vendor_name'];
            $spacepedia['category_id']=$data[0]['category_id'];
            // $spacepedia['vendor_id']=$data[0]['vendor_id'];
            $spacepedia['addr']=$data[0]['addr'];
            $spacepedia['attr']=$data[0]['attr_new'];
            $spacepedia['des']=$data[0]['des'];
            $_REQUEST['tab']="spacepedia";
        }else{
            $_REQUEST['tab']="space_item";
        }
        Tpl_Smarty::assign('_data',$spacepedia);
        Tpl_Smarty::assign('_product',$data[0]);
        Tpl_Smarty::assign('level',Data_Mysql_Table_Spacepedia::$level);
        Tpl_Smarty::display('OA_Static',"spacepedia/old_product_convert_edit.tpl");

    }

    //旧场地转换为场地百科数据提交
    static function submitSpacepediaInfo(){
        $request=Func_Input::filter(array(
            "space_id"=>'int',
            'product_id'=>'int',
            'data'=>'array',
            'data_i'=>'array',
        ));
        if(empty($request['product_id'])){
            Func_Header::back('参数缺失！');
        }
        //添加或修改场地百科
        // $request['data']['status']=2;
        $request['data']['space_id']=$request['space_id'];
        $request['data']['product_id']=$request['product_id'];
        $return=Api_Spacepedia_Submit::spacepediaInfoSubmit($request['data']);
        if($return['status'] ==1){
            Data_Mysql_Table_Product_Info::query("UPDATE {table} SET is_convert =1 WHERE id= ?",array($_REQUEST['product_id']),1);
            Data_Mysql_Table_Product_Info::query("UPDATE {table}_update SET is_convert =1 WHERE id= ?",array($_REQUEST['product_id']),1);

            //添加子空间

//            //处理该供应之前的拓展信息
//            if(!empty($request['data']['vendor_id'])){
//                $expand_data=self::handleExpandInfo($request['data']['vendor_id']);
//                if($expand_data['status']==-3){
//                    $request['data_i']['expand_status']=-3;
//                }
//            }
            //处理提交的标签
            if(!empty($request['data_i']['tags'])){
                $tags_arr=explode(",",$request['data_i']['tags']);
                unset($request['data_i']['tags']);
                foreach($tags_arr as $tk=>$tv){
                    //添加标签
                    $tags_id=Api_Demand_Offer_Check_Demand_Tag::getTagID($tv);
                    if($tags_id){
                        $request['data_i']['tags'][$tags_id]=1;
                    }else{
                        continue;
                    }

                }
            }
            $request['data_i']['status']=2;
            $request['data_i']['space_id']=$return['data'];
            $request['data_i']['product_id']=$request['product_id'];
            $request['data_i']['city']=$request['data']['attr'][46];
            $return_item=Api_Space_Item_Submit::spaceItemSubmit($request['data_i']);
            if($return_item){
//                //添加新的拓展数据
//                if(!empty($expand_data['admin_id'])){
//                    $expand_data['item_id']=$return_item;
//                    unset($expand_data['status']);
//                    Data_Mysql_Table_Item_Expand_New::insert($expand_data);
//                }
                Func_Header::to(' 已修改/创建新的场地百科和新的子空间，请等待审核！',"?");
            }else{
                Func_Header::back('创建场地百科失败');
            }
        }else{
            Func_Header::back($return['msg']);
        }
    }
    /*
     *处理某个供应商的旧拓展信息
     */
    // static function handleExpandInfo($vendor_id){
    //     $expand_data=array();
    //     //1.判断供应商是否已拓展丢弃
    //     $vendor_info=Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,status',array('id'=>$vendor_id,'status'=>-3));
    //     if(!empty($vendor_info[0])){
    //         $expand_data['status']=-3;
    //         return $expand_data;
    //     }
    //     //2.获取供应商的拓展信息
    //     $expand_log=Data_Mysql_Table_Expand_Log::select('*',array('vendor_id'=>$vendor_id));
    //     if(!empty($expand_log[0])){
    //         if($expand_log[0]['status']==-1){
    //             $expand_data['status']=-3;
    //             return $expand_data;
    //         }
    //         $expand_data['admin_id']=$expand_log[0]['admin_id'];
    //         $expand_data['admin_name']=$expand_log[0]['admin_name'];
    //         $expand_data['create_time']=$expand_log[0]['create_time'];
    //     }
    //     $expand_active=Data_Mysql_Table_Vendor_Expand::select('*',array('vendor_id'=>$vendor_id));
    //     if(!empty($expand_active[0])){
    //         $expand_data['status']=$expand_active[0]['status'];
    //         $expand_data['update_time']=$expand_active[0]['update_time'];
    //     }
    //     return $expand_data;

    // }

    //不转换场地
    static function abandonConvertProduct(){
        $request=Func_Input::filter(array(
            "product_id"=>"int",
            "is_convert"=>"int"
        ));
        if(empty($request['product_id'])){
            Func_Header::back("参数缺失！");
        }
        $rs=Data_Mysql_Table_Product_Info::query("UPDATE {table} SET is_convert =? WHERE id= ?",array($request['is_convert'],$request['product_id']),1);
        $rs_update=Data_Mysql_Table_Product_Info::query("UPDATE {table}_update SET is_convert =? WHERE id= ?",array($request['is_convert'],$request['product_id']),1);
        if(!empty($rs_update[0])){
            Func_Header::to(" 操作成功！！","?");
        }else{
            Func_Header::back("操作失败！！");

        }
    }
}