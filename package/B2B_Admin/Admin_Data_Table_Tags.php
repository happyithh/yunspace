<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/6
 * Time: 15:07
 */
class Admin_Data_Table_Tags extends Admin_Data_Table
{

    function ___dataTableHandler()
    {
        return Data_Mysql_Table_Tags::getInstance()->___handler;
    }

    function handleViewList()
    {
        Tpl_Smarty::assign('_table', self::getInstance()->___tableInfo);
        Tpl_Smarty::assign('_tags_tree', Data_Mysql_Table_Tags::getTreeCache());
        Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Tags::getInfoCache());
        Tpl_Smarty::display("B2B_Admin", 'pm_tags_list.tpl');
    }

    function handleViewEdit()
    {
        Tpl_Smarty::assign('_table', self::getInstance()->___tableInfo);
        if (empty($_REQUEST['url_to'])) {
            $_REQUEST['url_to'] = Core::$urls['referer'];
        }
        if (empty($_REQUEST['url_to'])) {
            Func_Header::back("参数错误!");
        }
        if (!empty($_REQUEST['ids'][0])) {
            $data = $this->___dataTableHandler->select('*', array('id' => $_REQUEST['ids'][0]));
            if (!empty($data[0])) {
                Tpl_Smarty::assign('_data', $this->handleDataForRead($data[0]));
            }
        }
        Tpl_Smarty::assign('_tags', Data_Mysql_Table_Tags::getTreeCache());
        Tpl_Smarty::display("B2B_Admin", 'pm_tags_edit.tpl');
    }

    function handleDataForWrite($data, $isInsert = 0)
    {
        if(empty($data['tags_name']) && empty($data['status'])){
            Func_Header::back('标签名称不能为空！！');
        }
        if(!empty($data['tags_value'])){
            $data['tags_value']=str_replace("，",',',$data['tags_value']);
        }
        return $data;
    }

    function handleOnWriteSuccess()
    {
        Data_Mysql_Table_Tags::clearCache();
    }

    function handleDataForRead($data)
    {
        if (!empty($data['attr_info'])) {
            $data['attr_info'] = json_decode($data['attr_info'], 1);
        }
        return $data;
    }
    //添加子标签
    static function handleAddSon(){
        if(!empty($_REQUEST['data'])){
            $request=Func_Input::filter(array(
                'parent_id'=>'int',
                'tags_name'=>'string',
                'sort_weight'=>'int',
                'tags_value'=>'string',
                'tags_type'=>'int',
            ),$_REQUEST['data']);
            if(empty($request['tags_name'])){
                Func_Header::back('标签名称不能为空！!');
            }
            if(!empty($request['tags_value'])){
                $request['tags_value']=str_replace('，',',',$request['tags_value']);
            }
            $rs = Data_Mysql_Table_Tags::insert($request);
            if (!empty($rs[0])) {
                Data_Mysql_Table_Tags::updateCache();
                Func_Header::to(' 子标签添加成功！！','tags');
            }
            Func_Header::back('子标签添加失败！！');

        }
        $tagsInfo = Data_Mysql_Table_Tags::select('parent_id,id', array('id' => $_REQUEST['ids'][0]));
        if (!empty($tagsInfo[0])) {
            Tpl_Smarty::assign('_data', $tagsInfo[0]);
        }
        Tpl_Smarty::assign('_tags', Data_Mysql_Table_Tags::getTreeCache());
        Tpl_Smarty::display("B2B_Admin", 'pm_tags_edit.tpl');
    }
//	function handleInfo(){
//		$_data=Data_Mysql_Table_Tags::getChildren($_REQUEST['ids'][0]);
//		$str=implode(',',$_data);
//		$conditions=array(
//			"id in(".$str.")"
//		);
//		$data=Data_Mysql_Table_Tags::page(0,10,"*",$conditions);
//		Tpl_Smarty::assign('_data', $data);
//		Tpl_Smarty::display("B2B_Admin", 'category_list.tpl');
//	}
//
//	function handleProductInfo(){
//		//q($_REQUEST);
//		$data=Data_Mysql_Table_Product_Info::page(0,10,"*","category_id=".$_REQUEST['ids'][0]);
//		//q($data);
//		Tpl_Smarty::assign('_table', self::getInstance()->___tableInfo);
//		Tpl_Smarty::assign('_data', $data);
//		Tpl_Smarty::display("B2B_Admin", 'product_list.tpl');
//
//	}

}