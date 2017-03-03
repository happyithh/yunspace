<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/27
 * Time: 15:11
 */
//q(Core::$urls['action']);

class Web_HelpCenter extends Page_Base
{

    function helpCenter()
    {
        $conditions[] = 'status>0';
        $order = 'ORDER BY create_time DESC';
        $data = Data_Mysql_Table_Help_Center::select("id,title,category", $conditions, $order, 15);
        return $data;
    }

    function helpDetail()
    {
        $action = explode(".", Core::$urls['action']);
        $key = explode("/", $action[0]);
        if (!empty($key[1]) && $key[0] == 'info') {
            $conditions['id'] = $key[1];
            $conditions[] = 'status>0';
            $data = Data_Mysql_Table_Help_Center::select("id,title,contents,category", $conditions);
            if (!empty($data)) {
                Data_Mysql_Table_Help_Center::hotSearch($data[0]['id']);
            }
            return $data;
        }
    }

    function helpCategory()
    {
        $action = explode(".", Core::$urls['action']);
        $key = explode("/", $action[0]);
        if (!empty($key[0]) && $key[0] == 'category') {
            $category = Data_Mysql_Table_Help_Center::$category;
            $conditions['category'] = $category[$key[1]];
            $conditions[] = 'status>0';
            $data = Data_Mysql_Table_Help_Center::select("id,title,category", $conditions, "", 100);
            return $data;
        }
    }

    function helpHot()
    {
        $condition[] = 'status > 0';
        $order = 'ORDER BY hotsearch DESC';
        $hot = Data_Mysql_Table_Help_Center::select('id,title,category', $condition, $order, 15);
        return $hot;
    }

    //  读取 帮助类型
    function readCategory()
    {
        $categorys = Data_Mysql_Table_Help_Center::$category;
        $conditions[] = 'status>0';
        $type = Data_Mysql_Table_Help_Center::select("category", $conditions, "", 1000);
        $category1 = array();
        foreach ($categorys as $k => $v) {
            foreach ($type as $kk => $vv) {
                foreach ($vv as $kkk => $vvv) {
                    if ($v == $vvv) {
                        $category1[$k] = $v;
                    }
                }
            }
        }
        return $category1;
    }

    //  搜索条下的 热门搜索
    function readHotSearch()
    {
        $hotsearchs = Data_Mysql_Table_Help_Center::$hotSearch;
        return $hotsearchs;
    }

    //   帮助中心搜索
    function searchHelpCenter()
    {
        $_REQUEST['keyword'] = trim($_REQUEST['keyword']);
        if (!empty($_REQUEST['keyword'])) {
            $filter = Func_Input::filter(array(
                'keyword' => 'string',
            ), $_REQUEST);
            $conditions['title'] = $filter['keyword'];
            $conditions[] = 'status>0';
            $order = 'ORDER BY create_time DESC';
            $result = Data_Mysql_Table_Help_Center::select("id,title,category", $conditions, $order, 100);
            return $result;
        } else {
            return '';
        }
    }
}
