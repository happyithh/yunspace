<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/6
 * Time: 15:07
 */
class Admin_Data_Table_Product_Category extends Admin_Data_Table
{

    function ___dataTableHandler()
    {
        return Data_Mysql_Table_Product_Category::getInstance()->___handler;
    }

    function handleViewList()
    {
        Tpl_Smarty::assign('_table', self::getInstance()->___tableInfo);
        Tpl_Smarty::assign('_category_tree', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_category_info', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display("B2B_Admin", 'product_category_list.tpl');
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
//                q($this->handleDataForRead($data[0]));
                Tpl_Smarty::assign('_data', $this->handleDataForRead($data[0]));
            }
        }
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_tags_tree', Data_Mysql_Table_Tags::getTreeCache());
        Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Tags::getInfoCache());
        Tpl_Smarty::display("B2B_Admin", 'product_category_edit.tpl');
    }

    function handleDataForWrite($data, $isInsert = 0)
    {
        unset($data['attr_info']['$$']);
        $data['attr_info'] = array_values($data['attr_info']);
        return $data;
    }

    function handleOnWriteSuccess()
    {
        Data_Mysql_Table_Product_Category::clearCache();
    }

    function handleDataForRead($data)
    {
        if (!empty($data['attr_info'])) {
            $data['attr_info'] = json_decode($data['attr_info'], 1);
        }
        if (!empty($data['tags_info'])) {
            $data['tags_info'] = json_decode($data['tags_info'], 1);
        }
        return $data;
    }

    function handleInfo()
    {
        $_data = Data_Mysql_Table_Product_Category::getChildren($_REQUEST['ids'][0]);
        $str = implode(',', $_data);
        $conditions = array(
            "id in(" . $str . ")"
        );
        $data = Data_Mysql_Table_Product_Category::page(0, 10, "*", $conditions);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display("B2B_Admin", 'category_list.tpl');
    }

    function handleProductInfo()
    {
        //q($_REQUEST);
        $data = Data_Mysql_Table_Product_Info::page(0, 10, "*", "category_id=" . $_REQUEST['ids'][0]);
        //q($data);
        Tpl_Smarty::assign('_table', self::getInstance()->___tableInfo);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display("B2B_Admin", 'product_list.tpl');

    }

}