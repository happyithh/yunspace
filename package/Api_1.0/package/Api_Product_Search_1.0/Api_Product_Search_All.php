<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/7/2
 * Time: 9:44
 */
class  Api_Product_Search_All extends Api
{
    static function  handle($args = '')
    {
        //接受参数
        //        'id' => 'int',
        //            'q' => 'string',
        //            'account_id' => 'int',    用户ID

        //返回结果：
        //         返回状态status （0，返回未成功，1返回成功），
        //         状态消息 msg：返回成功 或返回失败原因
        //         返回结果data：空间列表
        $args['account_id'] = Api_Session::user_id();
        return self::handleType($args);
    }

    static function  handleType($args)
    {
        $action = $_GET['action'];
        switch ($action) {
            case 'space':
                $data = self::handleSpaceInfoAutoComplete($args);
                break;
            case 'service':
                $data = self::handleServiceInfoAutoComplete($args);
                break;
            case 'set':
                $data = self::handleSetInfoAutoComplete($args);
                break;
            case 'product':
                $data = self::handleProductInfoAutoComplete($args);
                break;
            case 'all':
                $data = self::handleSearchAll($args);
                break;
            default:
                $data = self::request('error', '', '失败');
                break;
        }
        return $data;
    }

    //空间搜索
    static function handleSpaceInfoAutoComplete($args)
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
            'account_id' => 'int',
        ), $args);
        if (empty($request['id']) && empty($request['q'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if (!empty($request['id'])) {
            $rs = Data_Mysql_Table_Product_Search::select('id,logo,des, CONCAT( "[", id, "] ", product_name) as name,product_name as native_name', array("id = ? and status = ?" => array($request['id'], 1)));
        } else {
            $webConfig = Data_Config_Site::get('service_list');
            $children = Data_Mysql_Table_Product_Category::getChildren($webConfig['space_id']);
            $conditions["({table}.id like ? OR {table}.product_name like ?) AND {table}.status = ?"] = array($request['q'] . '%', $request['q'] . '%', 1);
            $conditions[] = 'category_id  IN (' . implode(',', $children) . ')';
            $cols = '{table}.id,{table}.logo,{table}.des,CONCAT( "[", {table}.id, "] ", {table}.product_name) as name,{table}.product_name as native_name,{prefix}follow_space.follow_id';
            $order = 'ORDER BY {prefix}follow_space.follow_id DESC';
            $table = '{table} LEFT JOIN {prefix}follow_space ON {table}.id = {prefix}follow_space.follow_id AND {prefix}follow_space.user_id =' . $request['account_id'] . ' AND {prefix}follow_space.is_cancel=0';
            $rs = Data_Mysql_Table_Product_Search::select($cols, $conditions, $order, 999, $table);
        }
        foreach ($rs as $k => $val) {
            if (!empty($val['follow_id'])) {
                $rs[$k]['name'] = ' ★' . $val['name'];
                $rs[$k]['native_name'] = ' ★' . $val['native_name'];
            }
            if (!empty($val['logo'])) {
                $rs[$k]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($val['logo'], 275, 195);
            }
            $rs[$k]['des'] = str_replace('&nbsp;', '', strip_tags($val['des']));
            if (!empty($rs[$k]['des'])) {
                $rs[$k]['des'] = mb_substr($rs[$k]['des'], 0, 34, 'utf-8');
            } else {
                $rs[$k]['des'] = '商家太懒没有留下介绍';
            }
            $rs[$k]['url'] = "http://" . Core::$urls['host'] . Core::$urls['root'] . 'service_info/' . $val['id'] . '.html';

        }
        return self::request('success', $rs, '成功');
    }

    //服务搜索
    static function handleServiceInfoAutoComplete($args)
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
            'account_id' => 'int',
        ), $args);
        if (empty($request['id']) && empty($request['q'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if (!empty($request['id'])) {
            $rs = Data_Mysql_Table_Product_Search::select('id,logo,des, CONCAT( "[", id, "] ", product_name) as name,product_name as native_name', array("id = ? and status = ?" => array($request['id'], 1)));
        } else {
            $webConfig = Data_Config_Site::get('service_list');

            $children = Data_Mysql_Table_Product_Category::getChildren($webConfig['space_id']);
            $conditions["({table}.id like ? OR product_name like ? ) AND status = ?"] = array($request['q'] . '%', $request['q'] . '%', 1);
            $conditions[] = 'category_id NOT IN (' . implode(',', $children) . ')';
            $cols = '{table}.id,{table}.logo,{table}.des,CONCAT( "[", {table}.id, "] ", {table}.product_name) as name,{table}.product_name as native_name,{prefix}follow_space.follow_id';
            $order = 'ORDER BY {prefix}follow_space.follow_id DESC';
            $table = '{table} LEFT JOIN {prefix}follow_space ON {table}.id = {prefix}follow_space.follow_id AND {prefix}follow_space.user_id =' . $request['account_id'] . ' AND {prefix}follow_space.is_cancel=0';
            $rs = Data_Mysql_Table_Product_Search::select($cols, $conditions, $order, 999, $table);
        }
        foreach ($rs as $k => $val) {
            if (!empty($val['follow_id'])) {
                $rs[$k]['name'] = ' ★' . $val['name'];
                $rs[$k]['native_name'] = ' ★' . $val['native_name'];
            }
            if (!empty($val['logo'])) {
                $rs[$k]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($val['logo'], 275, 195);
            }
            $rs[$k]['des'] = str_replace('&nbsp;', '', strip_tags($val['des']));
            if (!empty($rs[$k]['des'])) {
                $rs[$k]['des'] = mb_substr($rs[$k]['des'], 0, 34, 'utf-8');
            } else {
                $rs[$k]['des'] = '商家太懒没有留下介绍';
            }
            $rs[$k]['url'] = "http://" . Core::$urls['host'] . Core::$urls['root'] . 'service_info/' . $val['id'] . '.html';

        }
        return self::request('success', $rs, '成功');
    }

    //套餐服务
    static function handleSetInfoAutoComplete($args)
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
            'account_id' => 'int'
        ), $args);
        if (empty($request['id']) && empty($request['q'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if (!empty($request['id'])) {
            $rs = Data_Mysql_Table_Product_Set::select('id,logo,des, CONCAT( "[", id, "] ", set_name) as name,set_name as native_name', array("id = ? and status >= ?" => array($request['id'], 0)));
        } else {
            $conditions["({table}.id like ? OR set_name like ?) AND status >=?"] = array($request['q'] . '%', $request['q'] . '%', 0);
            $cols = '{table}.id,{table}.logo,{table}.des,CONCAT( "[", {table}.id, "] ", {table}.set_name) as name,{table}.set_name as native_name,{prefix}follow_set.follow_id';
            $order = 'ORDER BY {prefix}follow_set.follow_id DESC ';
            $table = '{table} LEFT JOIN {prefix}follow_set ON {table}.id = {prefix}follow_set.follow_id AND {prefix}follow_set.user_id =' . $request['account_id'] . ' AND {prefix}follow_set.is_cancel=0';
            $rs = Data_Mysql_Table_Product_Set::select($cols, $conditions, $order, 999, $table);

        }
        foreach ($rs as $k => $val) {
            if (!empty($val['follow_id'])) {
                $rs[$k]['name'] = ' ★' . $val['name'];
                $rs[$k]['native_name'] = ' ★' . $val['native_name'];
            }
            if (!empty($val['logo'])) {
                $rs[$k]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($val['logo'], 275, 195);
            }
            $rs[$k]['des'] = str_replace('&nbsp;', '', strip_tags($val['des']));
            if (!empty($rs[$k]['des'])) {
                $rs[$k]['des'] = mb_substr($rs[$k]['des'], 0, 34, 'utf-8');
            } else {
                $rs[$k]['des'] = '商家太懒没有留下介绍';
            }
            $rs[$k]['url'] = "http://" . Core::$urls['host'] . Core::$urls['root'] . 'set_info/' . $val['id'] . '.html';
            //
        }
        return self::request('success', $rs, '成功');
    }

    //无分类产品搜索
    static function handleProductInfoAutoComplete($args)
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
            'account_id' => 'int'
        ), $args);
        $cols = '{table}.id,{table}.logo,{table}.des,CONCAT( "[", {table}.id, "] ", {table}.product_name) as name,{table}.product_name as native_name,{prefix}follow_space.follow_id';
        $order = 'ORDER BY {prefix}follow_space.user_id DESC ,is_cancel ASC';
        $table = '{table} LEFT JOIN {prefix}follow_space ON {table}.id = {prefix}follow_space.follow_id AND {prefix}follow_space.user_id =' . $request['account_id'] . ' AND {prefix}follow_space.is_cancel=0';
        if (empty($request['id']) && empty($request['q'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if (!empty($request['id'])) {
            $rs = Data_Mysql_Table_Product_Search::select('id,logo,des, CONCAT( "[", id, "] ", product_name) as name,product_name as native_name', array("id = ? and status = ?" => array($request['id'], 1)));
        } else {
            $conditions["({table}.id like ? OR product_name like ? ) AND status = ?"] = array($request['q'] . '%', $request['q'] . '%', 1);
            $rs = Data_Mysql_Table_Product_Search::select($cols, $conditions, $order, 5, $table);
        }
        foreach ($rs as $k => $val) {

            $rs[$k]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($val['logo'], 100, 100);
            $rs[$k]['des'] = str_replace('&nbsp;', '', strip_tags($val['des']));
            if (!empty($rs[$k]['des'])) {
                $rs[$k]['des'] = mb_substr($rs[$k]['des'], 0, 34, 'utf-8');
            } else {
                $rs[$k]['des'] = '商家太懒没有留下介绍';
            }
        }
        return self::request('success', $rs, '成功');
    }

    //套餐和产品
    static function handleSearchAll($args)
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
            'account_id' => 'int'
        ), $args);
        $all = array();
        if (empty($request['id']) && empty($request['q'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if (empty($request['account_id'])) {
            $request['account_id'] = 0;
        }
        if (!empty($request['id'])) {
            $all[] = Data_Mysql_Table_Product_Search::select('id,logo,des, CONCAT( "[", id, "] ", product_name) as product_name,product_name as native_name', array("id = ? and status = ?" => array($request['id'], 1)));
            $all[] = Data_Mysql_Table_Product_Set::select('id,logo,des, CONCAT( "[", id, "] ", set_name) as set_name,set_name as native_name', array("id = ? and status >= ?" => array($request['id'], 0)));
        } else {
            //产品查询
            $cols1 = '{table}.id,{table}.id as product_id,{table}.logo,CONCAT( "[", {table}.id, "] ", {table}.product_name) as name,{table}.product_name, {table}.product_name as native_name,{prefix}follow_space.follow_id';
            $order1 = 'ORDER BY {prefix}follow_space.user_id DESC ,is_cancel ASC';
            $table1 = '{table} LEFT JOIN {prefix}follow_space ON {table}.id = {prefix}follow_space.follow_id AND {prefix}follow_space.user_id =' . $request['account_id'] . ' AND {prefix}follow_space.is_cancel=0';
            $conditions["({table}.id like ? OR product_name like ? ) AND status = ?"] = array($request['q'] . '%', $request['q'] . '%', 1);
            $all[] = Data_Mysql_Table_Product_Search::select($cols1, $conditions, $order1, 10, $table1);
            //套餐查询
            $conditio["({table}.id like ? OR set_name like ?) AND status >=?"] = array($request['q'] . '%', $request['q'] . '%', 0);
            $cols = '{table}.id,{table}.id as set_id,{table}.logo,CONCAT( "[", {table}.id, "] ", {table}.set_name) as name,{table}.set_name,{table}.set_name as native_name,{prefix}follow_set.follow_id';
            $order = 'ORDER BY {prefix}follow_set.follow_id DESC ';
            $table = '{table} LEFT JOIN {prefix}follow_set ON {table}.id = {prefix}follow_set.follow_id AND {prefix}follow_set.user_id =' . $request['account_id'] . ' AND {prefix}follow_set.is_cancel=0 ';
            $all[] = Data_Mysql_Table_Product_Set::select($cols, $conditio, $order, 3, $table);
        }
        $newArray = array();
        foreach ($all as $key => $val) {
            foreach ($val as $k => $v) {
                if (!empty($val['follow_id'])) {
                    $newArray[$k]['name'] = ' ★' . $val['name'];
                    $newArray[$k]['native_name'] = ' ★' . $val['native_name'];
                }
                $newArray[$k]['id'] = $v['id'];
                $newArray[$k]['product_id'] = $v['product_id'];
                $newArray[$k]['set_id'] = $v['set_id'];
                if ($v['set_name']) {
                    $newArray[$k]['name'] = '[套餐]-' . $v['set_name'];
                    $newArray[$k]['url'] = "http://" . Core::$urls['host'] . 'set_info/' . $v['id'] . '.html';

                }
                if ($v['product_name']) {
                    $newArray[$k]['name'] = '[场地]-' . $v['product_name'];
                    $newArray[$k]['url'] = "http://" . Core::$urls['host'] . 'service_info/' . $v['id'] . '.html';

                }
                $newArray[$k]['native_name'] = $v['native_name'];
            }
        }
        if (empty($newArray)) {
            $newArray = self::searchAll($request['q']);
        }
        return self::request('success', $newArray, '成功');

    }

    static function  searchAll($q)
    {

        //产品查询
        $cols1 = '{table}.id,{table}.id as product_id,{table}.logo,CONCAT( "[", {table}.id, "] ", {table}.product_name) as name,{table}.product_name, {table}.product_name as native_name';
        $conditions ['product_name'] = $q;
        $conditions['status=?'] = 1;
        $all[] = Data_Mysql_Table_Product_Search::select($cols1, $conditions, '', 10);
        //套餐查询
        $cols = '{table}.id,{table}.id as set_id,{table}.logo,CONCAT( "[", {table}.id, "] ", {table}.set_name) as name,{table}.set_name,{table}.set_name as native_name';
        $conditio ['set_name'] = $q;
        $conditio['status=?'] = 1;
        $all[] = Data_Mysql_Table_Product_Set::select($cols, $conditio, '', 3);

        $newArray = array();
        foreach ($all as $key => $val) {
            foreach ($val as $k => $v) {
                $newArray[$k]['id'] = $v['id'];
                $newArray[$k]['product_id'] = $v['product_id'];
                $newArray[$k]['set_id'] = $v['set_id'];
                if ($v['set_name']) {
                    $newArray[$k]['name'] = '[套餐]-' . $v['set_name'];
                    $newArray[$k]['url'] = "http://" . Core::$urls['host'] . 'set_info/' . $v['id'] . '.html';

                }
                if ($v['product_name']) {
                    $newArray[$k]['name'] = '[场地]-' . $v['product_name'];
                    $newArray[$k]['url'] = "http://" . Core::$urls['host'] . 'service_info/' . $v['id'] . '.html';

                }
                $newArray[$k]['native_name'] = $v['native_name'];
            }
        }
        return $newArray;

    }

}