<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/6
 * Time: 15:07
 */
class Admin_Data_Table_Vendor_Info extends Admin_Data_Table
{

    function ___dataTableHandler()
    {
        return Data_Mysql_Table_Vendor_Info::getInstance()->___handler;
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
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::all());
        Tpl_Smarty::display("B2B_Admin", 'vendor_info_edit.tpl');
    }

    private $_oldData = '';

    function handleDataForWrite($data, $isInsert = 0)
    {
        if (!isset($data['status']) && empty($data['vendor_name'])) {
            return false;
        }
        if (!empty($data['categories_id'])) {
            $data['categories_id'] = implode(',', $data['categories_id']);
        }
        unset($data['media']['$$']);
        if (!empty($data['media'])) {
            $data['media'] = array_values($data['media']);
            $data['media_num'] = count($data['media']);
        }
        //attr
        if (!empty($data['attr'])) {
            if (!empty($data['categories_id'])) {
                $data['attr']['服务范围'] = $data['categories_id'];
            }
            $data['attr_index'] = Data_Mysql_Table_Vendor_Info::attrToIndex($data['attr']);
            $rs = $this->___dataTableHandler->select('*', array('id' => $_REQUEST['ids'][0]));
            if (!empty($rs[0])) {
                $this->_oldData = $rs[0];
                if (empty($rs[0]['admin_id'])) {
                    $data['admin_id'] = empty($_SESSION['administrator']['id']) ? 0 : $_SESSION['administrator']['id'];
                }
            }
        }
        if ($isInsert) {
            $data['admin_id'] = empty($_SESSION['administrator']['id']) ? 0 : $_SESSION['administrator']['id'];
        }
        if (empty($data['vendor_account_id'])) {
            unset($data['vendor_account_id']);
        }
        return $data;
    }

    function handleOnWriteSuccess()
    {
        if (!empty($this->_oldData)) {
            Data_Mysql_Table_History::subTable('_vendor' . date("_Ym"))->insert(array(
                'object_id' => $_REQUEST['ids'][0],
                'admin_id' => empty($_SESSION['administrator']['id']) ? 0 : $_SESSION['administrator']['id'],
                'user_id' => empty($_SESSION['user']['id']) ? 0 : $_SESSION['user']['id'],
                'operate_type' => 1,
                'data_backup' => $this->_oldData,
            ));
        }
    }


    function handleDataForRead($data)
    {
        if (!empty($data['categories_id'])) {
            $data['categories_id'] = explode(',', $data['categories_id']);
        }
        if (!empty($data['base_info'])) {
            $data['base_info'] = json_decode($data['base_info'], 1);
        }
        if (!empty($data['attr'])) {
            $data['attr'] = json_decode($data['attr'], 1);
        }
        if (!empty($data['media'])) {
            $data['media'] = json_decode($data['media'], 1);
        }
        return $data;
    }
}