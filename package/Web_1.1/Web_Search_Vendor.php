<?php

/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 15/7/17
 * Time: 11:41
 */
class Web_Search_Vendor extends Page_Base
{
    function __construct()
    {
        $this->topCategoryId;
    }

    //默认值
    function  webConfig()
    {
        return Data_Config_Site::get('service_list');
    }

    function  request()
    {
        $request = Func_Input::filter(array(
            'keyword' => 'string',
            'category_id' => 'int',
            'filter' => 'array',
            "activity" => "string",
            "industry" => "string",
            'orderBy' => 'int',
        ), $_REQUEST);

        if (!empty($request['activity'])) {
            $request['filter']['活动类型'] = $request['activity'];
        }
        if (!empty($request['industry'])) {
            $request['filter']['服务行业'] = $request['industry'];
        }

        if (!empty($request['filter'])) {
            foreach ($request['filter'] as $k => $v) {
                if ($v == 'all') {
                    unset($request['filter'][$k]);
                }
            }
        }
        return $request;
    }


    //分类categoryId
    function  categoryId()
    {

        if (!empty($this->request['category_id'])) {
            $categoryId = $this->request['category_id'];
        } elseif (is_numeric(Core::$urls['action'])) {
            $categoryId = Core::$urls['action'];
        } else {
            $categoryId = 0;
        }
        return $categoryId;
    }

    //搜索条件
    function  conditions()
    {
        $conditions = array(
            'status' => 1,
        );
        $request = $this->request;
        $categoryId = $this->categoryId;

        //分类
        if (!empty($categoryId)) {
            $children = Data_Mysql_Table_Product_Category::getChildren($categoryId);
            $children[] = $categoryId;
            $conditions[] = 'categories_id in (' . implode(',', $children) . ')';
        }

        //搜索
        if (!empty($request['keyword'])) {
            $conditions['vendor_name'] = $request['keyword'];
            $conditions['addr'] = $request['keyword'];
        }

        if (!empty($request['filter'])) {
            $conditions['attr_index'] = array();
            foreach ($request['filter'] as $k => $v) {
                $conditions['attr_index'][$k] = '+' . $v;
            }
        }

//        q($conditions);
        return $conditions;

    }


    function  getVendorList()
    {
        $conditions = $this->conditions;
        $webConfig = $this->webConfig;
        $request = $this->request;

        //排序方式
        switch ($request['orderBy']) {
            case '2':
                $order = 'ORDER BY id DESC';
                break;
            case '3':
                $order = 'ORDER BY counter_view DESC';
                break;
            default:
                //浏览量+收藏量+订单成交量（定义一个综合评分的算法）
                $order = 'ORDER BY (counter_view+counter_follow+counter_order+update_time) DESC';
                break;
        }
        $list = Data_Mysql_Table_Vendor_Info::page(0, empty($webConfig['page_num']) ? 10 : $webConfig['page_num'], "id,vendor_name, attr_index, logo, addr,vendor_remarks", $conditions, $order);
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
                $list['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
                $list['rows'][$k]['vendor_remarks'] = json_decode($v['vendor_remarks'], 1);
                //$list['rows'][$k]['media'] = array();
            }
            Data_Mysql_Table_Search_Log::searchLog($request['keyword'], $request['filter'], $list['page']['dt']);
        }
        return $list;
    }

    function id()
    {
        $action_arr = explode('/', Core::$urls['action']);
        if (count($action_arr) == 2) {
            return substr($action_arr[1], 0, -5);
        } else {
            return substr($action_arr[0], 0, -5);
        }
    }

    function isUpdate()
    {
        return Web_Vendor_Info::isUpdate();
    }

    function VendorInfo()
    {
        return Web_Vendor_Info::vendorInfo();
    }


    function productInfo()
    {
        //读取供应商的产品信息
        return Web_Vendor_Info::productInfo();

    }

    function  categoryTree()
    {
        $webConfig = $this->webConfig;
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        unset($categoryTree[0][$webConfig['space_id']], $categoryTree[0][93], $categoryTree[0][10], $categoryTree[0][140], $categoryTree[0][3], $categoryTree[0][135]);
        return $categoryTree;
    }


    //手机端获取活动类型，行业类型
    function  getPhoneAttr($type)
    {
        $result = Data_Config_Vendor_Attr::get('attr');
        switch ($type) {
            case 1:
                return $result['活动类型'];
                break;
            case 2:
                return $result['服务行业'];
                break;
            default:
                return '';
                break;

        }
    }


    static function handleGetListForMobile()
    {
        return self::getInstance()->getListForMobile();
    }

    //手机端获取列表
    function  getListForMobile()
    {
        $conditions = $this->conditions;
        $webConfig = $this->webConfig;
        $request = $this->request;
        //排序方式
        switch ($request['orderBy']) {
            case '2':
                $order = 'ORDER BY id DESC';
                break;
            case '3':
                $order = 'ORDER BY order_counter_view DESC';
                break;
            default:
                $order = 'ORDER BY (counter_view+counter_follow+counter_order+update_time) DESC';
                break;
        }
        $dataresult['rows'] = Web_Search_Vendor::fetch("Web_Mobile_Static::list_template.v1.0/vendor_list.tpl");

        $dataresult['page'] = $this->getVendorList['page'];
        $req = array();
        if (!empty($request['filter']['活动类型'])) {
            $arr = $this->getPhoneAttr(1);
            $req['activity'] = array_search($request['filter']['活动类型'], $arr) + 1;
        }
        if (!empty($request['filter']['服务行业'])) {
            $arr = $this->getPhoneAttr(2);
            $req['industry'] = array_search($request['filter']['服务行业'], $arr) + 1;
        }
        if (!empty($request['category_id'])) {
            $req['category_id'] = $request['category_id'];
        }
        if (!empty($request['orderBy'])) {
            $req['orderBy'] = $request['orderBy'];
        }
        $dataresult['req'] = $req;
//        q($dataresult['req']);
        Func_Output::json("success", $dataresult, "成功");
    }


}