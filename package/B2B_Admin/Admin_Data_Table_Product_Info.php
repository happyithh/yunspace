<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/6
 * Time: 15:07
 */
Core::$debug = 1;

class Admin_Data_Table_Product_Info extends Admin_Data_Table
{

    function ___dataTableHandler()
    {
        return Data_Mysql_Table_Product_Info::getInstance()->___handler;
    }

    function handleViewList()
    {
        Tpl_Smarty::assign('_table', self::getInstance()->___tableInfo);
        //设置过滤条件
        $conditions = self::$_filter;
        if (!empty($_REQUEST['search'])) {
            if (is_array($_REQUEST['search']) && $this->___dataTableHandler->_table->___indexInfo) {
                foreach ($this->___dataTableHandler->_table->___indexInfo as $k => $v) {
                    if (!empty($_REQUEST['search'][$v])) {
                        $conditions[$k] = $_REQUEST['search'][$v];
                    }
                }
            }
        }
        if (isset($this->___dataTableHandler->_table->cols[$this->filterCol])) {
            if (isset($_REQUEST['filter_id'])) {
                $conditions[$this->filterCol] = $_REQUEST['filter_id'];
            } else {
                $conditions[$this->filterCol] = 1;
            }
        }
        $order = empty($this->___dataTableHandler->_table->cols['update_time']) ? 'ORDER BY id DESC' : 'ORDER BY update_time DESC';
        $data = $this->___dataTableHandler->page(0, 0, '*', $conditions, $order);
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                $data['rows'][$k] = $this->handleDataForRead($v);
            }
        }
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display("B2B_Admin", 'product_info_list.tpl');
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
        Tpl_Smarty::display("B2B_Admin", 'product_info_edit.tpl');

    }

    private $_oldData = '';

    function handleDataForWrite($data, $isInsert = 0)
    {
        unset($data['media']['$$']);
        if (!empty($data['media'])) {
            $data['media'] = array_values($data['media']);
            $data['media_num'] = count($data['media']);
        }
        if (!empty($data['vendor_name'])) {
            $data['vendor_id'] = intval(substr($data['vendor_name'], 1));
        }
        //attr
        if (!empty($data['attr'])) {
            $data['attr_index'] = Data_Mysql_Table_Product_Info::attrToIndex($data['attr']);
            $rs = $this->___dataTableHandler->select('*', array('id' => $_REQUEST['ids'][0]));
            if (!empty($rs[0])) {
                $this->_oldData = $rs[0];
                if (empty($rs[0]['admin_id'])) {
                    $data['admin_id'] = empty($_SESSION['administrator']['id']) ? 0 : $_SESSION['administrator']['id'];
                }
            }
            foreach ($data['attr'] as $k => $v) {
                if (strpos($k, '面积') !== false) {
                    $data['product_size'] = intval($v);
                    break;
                }
            }
            if (!$data['vendor_id']) {
                Func_Header::back('供应商填写有误!');
            }
        }
        if (!empty($data['price'])) {
            $data['price'] *= 100;
        } elseif (!is_numeric($data['price'])) {
            unset($data['price']);
        }
//        if (empty($data['addr'])) {
//            unset($data['addr']);
//        }
        if ($isInsert) {
            $data['admin_id'] = empty($_SESSION['administrator']['id']) ? 0 : $_SESSION['administrator']['id'];
        }
        return $data;
    }

    function handleOnWriteSuccess()
    {
        if (!empty($this->_oldData)) {
            Data_Mysql_Table_History::subTable('_product' . date("_Ym"))->insert(array(
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
        if (!empty($data['attr'])) {
            $data['attr'] = json_decode($data['attr'], 1);
        }
        if (!empty($data['attr_new'])) {
            $data['attr_new'] = json_decode($data['attr_new'], 1);
        }
        if (!empty($data['media'])) {
            $data['media'] = json_decode($data['media'], 1);
        }
        if (!empty($data['price'])) {
            $data['price'] /= 100;
        }
        return $data;
    }

    static function handleVendorAutoComplete()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            die('参数错误!');
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Vendor_Info::select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("id" => $request['id']));
        } else {
            $rs = Data_Mysql_Table_Vendor_Info::select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("id like ? OR vendor_name like ?" => array($request['q'] . '%', $request['q'] . '%')), '', 5);
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => 1,
                    'name' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['name'] = '';
            $ajax_arr['items'][$key]['full_name'] = $val['name'];
        }
        echo json_encode($ajax_arr);
        die();
    }

    static function handleProductInfoAutoComplete()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'q' => 'string',
        ));
        if (!$request['product_id'] && !$request['q']) {
            die('参数错误!');
        }
        if ($request['product_id']) {
            $rs = Data_Mysql_Table_Product_Info::select('id, CONCAT( "[", id, "] ", product_name) as name', array("id = ? and status >= ?" => array($request['product_id'],0)));
        } else {
            $rs = Data_Mysql_Table_Product_Info::select('id, CONCAT( "[", id, "] ", product_name) as name', array("id like ? OR product_name like ? AND status >=?" => array($request['q'] . '%', $request['q'] . '%',0)), '', 5);
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => 0,
                    'name' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['name'] = '';
            $ajax_arr['items'][$key]['full_name'] = $val['name'];
        }
        echo json_encode($ajax_arr);
        die();
    }
}