<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-4-16
 * Time: 下午4:44
 */
class OA_My_Customer_Handle_Product
{
    /*
     *添加产品
     */
    static function handle(){
        if(empty($_REQUEST['vendor_id'])){
            Func_Header::back('参数缺失！');
        }

        if(empty($_REQUEST['product_id'])){
            if (!empty($_REQUEST['is_submit_add_product'])) {
                self::handleAdd();
            }else{
                self::getProductList();
            }
        }else{
            if (!empty($_REQUEST['is_submit'])) {
                self::handleEditProduct();
//            } elseif (!empty($_REQUEST['is_submit_case'])) {
//                self::handleEditCase();
//            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'case') {
//                self::handleCaseShow();
//            }elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'caseshow'){
//                self::handleProductCase();
            } elseif (!empty($_REQUEST['is_submit_deliver'])) {
                self::handleSubmitDeliver();
            }elseif(!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type']=="deliver"){
                self::handleDeliverEdit();
            }else {
                self::handleShow();
            }
        }
    }
    static function getProductList(){
        $conditions = array();
        if (!empty($categoryId)) {
            $children = Data_Mysql_Table_Product_Category::getChildren(abs($categoryId));
            $children[] = abs($categoryId);
            if ($categoryId > 0) {
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
            } else {
                $conditions[] = '{table}.category_id not in (' . implode(',', $children) . ')';
            }
        }
        //搜索框传过来的ID或者套餐名称
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'category_id' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['product_name'] = $search['title'];
                }
            }
            //服务分类筛选
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Product_Category::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
            }
        }
        $productInfo = Api_Vendor_Get_All_List::getProductListByVendorId($_REQUEST['vendor_id'],$conditions);

        //获取当前供应商的分类信息
        $categories = Api_Vendor_Info::getCategoryInfo($_REQUEST['vendor_id']);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_categories', $categories);
        Tpl_Smarty::assign('productInfo', $productInfo);
    }
    static function handleAdd()
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'category_id' => 'int',
            'product_name' => 'string',
            'city' => 'string',
        ));
        if (empty($request['product_name'])) {
            Func_Header::back('产品名称不能为空！！');
        }
        $data['product_name'] = $request['product_name'];
        $data['vendor_id'] = $request['vendor_id'];
        $data['category_id'] = $request['category_id'];
        $data['attr_new'][46] = $request['city'];
        $data['status'] = 2;
        $rs = Data_Mysql_Table_Product_Info::subTable('_update')->insert($data);
        if ($rs[0] > 0) {
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($request['vendor_id'], 2)), array('status' => 4));
            Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&vendor_id=' . $request['vendor_id']);
        } else {
            Func_Header::back('产品信息提交失败！！');
        }

    }

    /*
     *展示产品信息
     */
    static function handleShow()
    {
        if (empty($_REQUEST['product_id'])) {
            Func_Header::back('参数错误！');
        }
        $category = Data_Mysql_Table_Product_Category::getInfoCache();
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', array('id' => $_REQUEST['product_id']), 'ORDER BY update_time DESC');
        if (empty($data)) {
            $data = Data_Mysql_Table_Product_Info::select('*', array('id' => $_REQUEST['product_id']));
        }
        if (!empty($data)) {
            if (!empty($data[0]['attr'])) {
                $data[0]['attr'] = json_decode($data[0]['attr'], 1);
            }
            if (!empty($data[0]['attr_new'])) {
                $data[0]['attr_new'] = json_decode($data[0]['attr_new'], 1);
            }
            if (!empty($data[0]['media'])) {
                $data[0]['media'] = json_decode($data[0]['media'], 1);
            }
            if (!empty($data[0]['price'])) {
                $data[0]['price'] = $data[0]['price'] / 100;
            }
        }
        Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($data[0]['category_id']));
        Tpl_Smarty::assign('_category', $category);
        Tpl_Smarty::assign('_data', $data[0]);
    }

    static function handleProductCase(){
        if (empty($_REQUEST['product_id'])) {
            Func_Header::back('参数错误！');
        }
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', array('id' => $_REQUEST['product_id']), 'ORDER BY update_time DESC');
        $case_rs =Api_Case_List_And_Info::getCaseList($_REQUEST['product_id'],"update",'product');
        if(empty($case_rs["status"])){
            Func_Header::back($case_rs['msg']);
        }
        Tpl_Smarty::assign('_event', $case_rs['data']);
        Tpl_Smarty::assign('_data', $data[0]);
    }
    /*
     *修改产品信息
     */
    static function handleEditProduct()
    {
        $_REQUEST['edit'] = '1';
        $rs = Api_Product_Submit::handle($table="update",$_REQUEST);
        if($rs['status']==0) {
            Func_Header::back($rs['msg']);
        }
        if (!empty($rs['data']) && $rs['data'] > 0) {
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($_REQUEST['vendor_id'], 2)), array('status' => 4));
            if(!empty($_REQUEST['is_back'])) {
                $back_url = str_replace('my_vendor_list','vendor_candidate',Core::$urls['path']);
                Func_Header::to(' 数据处理成功！', $back_url);
            }else{
                Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&vendor_id=' . $_REQUEST['vendor_id']);
            }
        }
        Func_Header::to('操作错误！！');
    }
    //投稿表单
    static function handleDeliverEdit(){
        //定义操作内容
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        foreach($categoryName as $k=>$v){
            $category_name[$v['id']]=$v;
        }
        Tpl_Smarty::assign('category_name', $category_name);

        //定义文章状态
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);

        //定义关键字
        $vendorAttr = Data_Config_Vendor_Attr::get('attr');
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);
    }
    //投稿表单提交
    static function handleSubmitDeliver(){
        $data=OA_Raiders_Info::handleSubmitData();
        unset($data['create_time']);
        $data['from_where'] = 3;
        $data['status'] = 2;
        if(!empty($_REQUEST['product_id'])){
            //获取上线的场地
            $product=Data_Mysql_Table_Product_Info::select('id,product_name',array("id"=>$_REQUEST['product_id'],'status'=>1));
        }
        if(!empty($_REQUEST['set_id'])){
            //获取上线的套餐
            $set=Data_Mysql_Table_Product_Set::select('id,set_name',array("id"=>$_REQUEST['set_id'],'status'=>1));
        }

        if(!empty($product[0]) || !empty($set[0])){
            $data['cont'].="<p>相关场地/套餐链接&nbsp;:&nbsp;";
            if(!empty($product[0]) && !empty($product[0]['product_name'])){
                $data['cont'].="<a target='_blank' href='http://www.yunspace.com.cn/service_info/".$product[0]['id'].".html'>".$product[0]['product_name']."</a><br/>";
            }
            if(!empty($set[0]) && !empty($set[0]['set_name'])){
                $data['cont'].="<a target='_blank' href='http://www.yunspace.com.cn/set_info/".$set[0]['id'].".html'>".$set[0]['set_name']."</a><br/>";
            }
            $data['cont'].='</p>';
        }
        $rows = Data_Mysql_Table_Raiders_Info::subTable('_update')->insert($data);
        if (!empty($rows[0])) {
            Func_Header::to(' 投稿成功，可以去投稿审核列表查看和审核！', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&vendor_id=' . $_REQUEST['vendor_id']);
        } else {
            Func_Header::back('投稿失败！');
        }
    }



//    /*
//     *获取案例相关信息
//     */
//    static function handleCaseShow()
//    {
//        $caseInfo=array();
//        if (empty($_REQUEST['product_id'])) {
//            Func_Header::back('参数错误! ');
//        }
//        //获取当前产品信息
//        $product = Data_Mysql_Table_Product_Info::subTable('_update')->select('id, product_name, vendor_id', array('id' => $_REQUEST['product_id']));
//        if (empty($product[0]['id'])) {
//            Func_Header::back('参数错误! ');
//        }
//        Tpl_Smarty::assign('_product', $product[0]);
//        //获取活动类型和行业标签
//        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
//        if(!empty($_REQUEST['case_id'])){
//            $case_rs=Api_Case_List_And_Info::getCaseInfo('update',$_REQUEST['case_id']);
//            if(empty($case_rs['status'])){
//                Func_Header::back($case_rs['msg']);
//            }
//            $caseInfo=$case_rs['data'];
//        }
//
//        Tpl_Smarty::assign('_data',$caseInfo );
//    }
//
//    /*
//     *添加或修改案例
//     */
//    static function handleEditCase()
//    {
//        $request = Func_Input::filter(array(
//            'product_id' => 'int',
//            'case_id' => 'int',
//            'vendor_id' => 'int',
//            'data' => 'array',
//        ));
//        if (!$request['product_id']) {
//            Func_Header::back("参数缺失！");
//        }
//        $case_rs=Api_Case_Submit::handle();
//        if(empty($case_rs['status'])){
//            Func_Header::back($case_rs['msg']);
//        }else{
//            Func_Header::to(' 操作成功，正在审核!', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&handle_type=caseshow' . '&product_id=' . $_REQUEST['product_id'] . '&vendor_id=' . $request['vendor_id']);
//        }
//    }

}