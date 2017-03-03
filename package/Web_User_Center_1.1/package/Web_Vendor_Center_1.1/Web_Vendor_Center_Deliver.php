<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-14
 * Time: 下午2:31
 */
class Web_Vendor_Center_Deliver{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getDeliverList();
                break;
            case "edit":
                self::editDeliver();
                break;
            case "submit_deliver":
                self::submitDeliver();
                break;
            case "delete":
                self::handleRaidersDelete();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    //获取投稿列表
    static function getDeliverList(){
        //定义操作内容
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        foreach($categoryName as $k=>$v){
            $category_name[$v['id']]=$v;
        }
        Tpl_Smarty::assign('category_name', $category_name);
        $condition['{table}.account_id = ?']=$_SESSION['user']['id'];
        $request=Func_Input::filter(array(
            'text'=>'string',
        ));
        if(!empty($request['text'])){
            $condition['({table}.title = ? OR {table}.author = ?)']=array($_REQUEST['text'],$_REQUEST['text']);
        }
        if(!empty($_REQUEST['status'])){
            $condition['{table}.status = ?']=$_REQUEST['status'];
        }
        $data=Data_Mysql_Table_Raiders_Info::subTable('_update')->page(0,20,'{table}.*,{prefix}raiders_info.id as online_id',$condition,"ORDER BY {table}.update_time DESC","{table} LEFT JOIN {prefix}raiders_info ON {table}.id = {prefix}raiders_info.update_id");
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display("Web_Vendor_Center","deliver/deliver_list.tpl");
    }

    //增加或修改投稿信息
    static function editDeliver(){
        //定义操作内容
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        foreach($categoryName as $k=>$v){
            $category_name[$v['id']]=$v;
        }
        Tpl_Smarty::assign('category_name', $category_name);

        if(!empty($_REQUEST['id'])){
            $data=Data_Mysql_Table_Raiders_Info::subTable('_update')->select("*",array('id'=>$_REQUEST['id']));
            if(empty($data[0])){
                Func_Header::back('数据不存在！');
            }
            if(!empty($data[0]['tags_info'])){
                $data[0]['tags_info']=json_decode($data[0]['tags_info'],1);
            }
            if(!empty($data[0]['detail_des'])){
                $data[0]['detail_des']=json_decode($data[0]['detail_des'],1);
            }
            Tpl_Smarty::assign('_data',$data[0]);
        }

        //定义关键字
        $vendorAttr = Data_Config_Vendor_Attr::get('attr');
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);
        Tpl_Smarty::display("Web_Vendor_Center","deliver/deliver_edit.tpl");
    }

    //投稿信息表单提交
    static function submitDeliver(){
        $data=OA_Raiders_Info::handleSubmitData();
        $data['create_time']=time();
        $data['from_where'] = 3;
        $data['status'] = 2;
        $data['account_id'] = $_SESSION['user']['id'];
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
        $rows = Data_Mysql_Table_Raiders_Info::subTable('_update')->update($data);
        if (!empty($rows[0])) {
            Func_Header::to(' 投稿成功，请耐心等待审核！',"?");
        } else {
            Func_Header::back('投稿失败！');
        }
    }
    static function handleRaidersDelete(){
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $conditions['id'] = $_REQUEST['id'];
        $update_rs = Data_Mysql_Table_Raiders_Info::subTable('_update')->delete($conditions);
        $rs = Data_Mysql_Table_Raiders_Info::delete(array('update_id'=>$_REQUEST['id']));
        if (!empty($update_rs[0])) {
            $update_data=Data_Mysql_Table_Raiders_Info::select("id,update_id,space_ids", array('id'=>$_REQUEST['id']));
            //更新关联百科的文章总数
            if(!empty($update_data[0]['space_ids'])){
                $space_arr=json_decode($update_data[0]['space_ids'],1);
                $space_ids=explode(",",$space_arr);
                Api_Baike_Article_Count::updateAricleCountBySpaceIds($space_ids);
            }
            Func_Header::to(' 删除成功！！', Core::$urls['path']);
        } else {
            Func_Header::back('删除失败！！');
        }
    }
}