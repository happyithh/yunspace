<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/26
 * Time: 15:14
 */
//header("Cache-Control: no-cache, must-revalidate");
//header("Pragma: no-cache");
$categoryId = Core::$urls['action'];
if ($categoryId && !is_numeric($categoryId)) {
    Func_Header::notFound();
}
if (!$categoryId) {
//    Func_Header::location(Core::$urls['root'] . 'service/2');
}
//开始绑定数据，渲染页面
$webConfig = Data_Config_Site::get('service_list');
/**
 * 加载列表项
 */

//定义空间面积范围数组
$size_range = array(
    0 => '全部',
    1 => '500平米以下',
    500 => '500-1000平米',
    1000 => '1000-2000平米',
    2000 => '2000平米以上',
);
//只显示通过审核的产品
$conditions = array(
    'status' => 1,

);
//分类
if ($categoryId) {
    $children = Data_Mysql_Table_Product_Category::getChildren($categoryId);

    $children[] = $categoryId;
    $conditions[] = 'category_id in (' . implode(',', $children) . ')';
} else {
    $children = Data_Mysql_Table_Product_Category::getChildren($webConfig['space_id']);
    $children[] = $webConfig['space_id'];
    $conditions[] = 'category_id not in (' . implode(',', $children) . ')';
}
//关键词&&属性筛选
if (!empty($_REQUEST['filter'])) {
    foreach ($_REQUEST['filter'] as $k => $v) {
        if ($v == 'all') {
            unset($_REQUEST['filter'][$k]);
        }
    }
}
$request = Func_Input::filter(array(
    'keyword' => 'string',
    'filter' => 'array',
    'size_range' => 'int',
));
if ($request['keyword']) {
    $conditions['product_name'] = $request['keyword'];
    $conditions['addr'] = $request['keyword'];
}
if ($request['size_range']) {
    $product_size = $request['size_range'];
    switch ($product_size) {
        case 1:
            $conditions[] = 'product_size < 500';
            break;
        case 500:
            $conditions[] = 'product_size >=500 and  product_size < 1000';
            break;
        case 1000:
            $conditions[] = 'product_size >=1000 and  product_size < 2000';
            break;
        case 2000:
            $conditions[] = 'product_size > 2000';
            break;
        default :
            '';
            break;
    }
}
if ($request['filter']) {
    $conditions['attr_index'] = array();
    foreach ($request['filter'] as $k => $v) {
        $conditions['attr_index'][$k] = '+' . $v;
    }
}
$filterString = http_build_query($request);
Tpl_Smarty::assign('filter_string', $filterString . '&');
if (!empty($_COOKIE['city'])) {
    $conditions['attr_index']['城市'] = '+' . $_COOKIE['city'];
} else {
    $_COOKIE['city'] = '上海';
}
//排序方式
$order = 'ORDER BY update_time DESC';
//查询数据库
$list = Data_Mysql_Table_Product_Info::page(0, empty($webConfig['page_num']) ? 10 : $webConfig['page_num'], "id, category_id, vendor_id, product_name, attr, media, price, addr, update_time", $conditions, $order);
$vendors = array();
if (!empty($list['rows'])) {
    foreach ($list['rows'] as $k => $v) {
        $vendors[] = $v['vendor_id'];
        $list['rows'][$k]['price'] /= 100;
        $list['rows'][$k]['attr'] = json_decode($v['attr'], 1);
        $list['rows'][$k]['media'] = array();
        $v['media'] = json_decode($v['media'], 1);
        if (!empty($v['media'])) {
            foreach ($v['media'] as $mk => $mv) {
                //主图
                if (empty($list['rows'][$k]['logo'])) {
                    $list['rows'][$k]['logo'] = $mv['path'];
                }
                $mvTags = explode(',', $mv['tags']);
                foreach ($mvTags as $mTag) {
                    if ($mTag == '@主图') {
                        $list['rows'][$k]['logo'] = $mv['path'];
                    }
                    $list['rows'][$k]['media'][$mTag][$mv['path']] = $mv['name'];
                }
            }
        }
    }
    $rs = Data_Mysql_Table_Vendor_Info::select("id, vendor_name", array("id IN (" . implode(',', $vendors) . ")"), '', 100);
    $vendors = array();
    foreach ($rs as $v) {
        $vendors[$v['id']] = $v;
    }
}
//处理属性
$categoryId = intval($categoryId);
$filterAttr = Data_Mysql_Table_Product_Info::getProductAttrWithValues($categoryId, $conditions);
$allCategory = Data_Mysql_Table_Product_Category::getInfoCache();
$parents = array();
$topCategoryId = $categoryId;
$parents[] = $topCategoryId;
while (!empty($allCategory[$topCategoryId][3])) {
    $topCategoryId = $allCategory[$topCategoryId][3];
    $parents[] = $topCategoryId;
}
Data_Config_Site::seo('service_list', array(
    'category_name' => ($categoryId ? $allCategory[$categoryId][0] : '全部服务'),
));
$showAttrs = array(
    '基本信息>适合活动类型' => 1,
    '基本信息>行政区域' => 1,
    '基本信息>适合活动类型' => 1,
    '基础信息>服务行业类型' => 1,
    '基本信息>服务行业类型' => 1,
);
foreach ($filterAttr as $k => $v) {
    if (empty($showAttrs[$k])) {
        unset($filterAttr[$k]);
    }
}
//unset($filterAttr['城市'], $filterAttr['基本信息>轨道交通'], $filterAttr['基本信息>餐饮配套'], $filterAttr['基本信息>使用面积']);
//unset($filterAttr['基础信息>搭建材质'], $filterAttr['基础信息>工艺类型'], $filterAttr['基础信息>加工方式']);
//unset($filterAttr['基础信息>搭建面积'], $filterAttr['基础信息>设备类型'], $filterAttr['基础信息>演出范围'], $filterAttr['基础信息>礼仪范围']);
//unset($filterAttr['基本信息>服务行业类型']);
//unset($filterAttr['基本信息>服务行业类型'], $filterAttr['基本信息>项目类型'], $filterAttr['基本信息>制作类型']);
//unset($filterAttr['基本信息>搭建材质'], $filterAttr['基本信息>工艺类型'], $filterAttr['基本信息>加工方式'], $filterAttr['基本信息>拍摄类型'], $filterAttr['基本信息>客户名称']);
//unset($filterAttr['基本信息>搭建面积'], $filterAttr['基本信息>设备类型'], $filterAttr['基本信息>演出范围'], $filterAttr['基本信息>礼仪范围'], $filterAttr['基本信息>拍摄周期']);
if (Data_Config_Site::isSpace($topCategoryId) || !empty($filterAttr['基本信息>服务行业类型'])) {
    unset($filterAttr['基础信息>服务行业类型']);
}
$categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
unset($categoryTree[0][$webConfig['space_id']], $categoryTree[0][93], $categoryTree[0][10], $categoryTree[0][140], $categoryTree[0][3], $categoryTree[0][135]);
//猜你喜欢数据
$guessConditions = Web_Account::getFootPrintConditions();
$guessConditions['attr_index']['城市'] = '+' . $_COOKIE['city'];

$guessConditions['status'] = 1;
$guessList = Data_Mysql_Table_Product_Info::select('id, product_name, media', $guessConditions, '', 5);
if (!empty($guessList)) {
    foreach ($guessList as $k => $v) {
        $v['media'] = json_decode($v['media'], 1);
        if (!empty($v['media'])) {
            foreach ($v['media'] as $mk => $mv) {
                //主图
                if (empty($guessList[$k]['logo'])) {
                    $guessList[$k]['logo'] = $mv['path'];
                }
                $mvTags = explode(',', $mv['tags']);
                foreach ($mvTags as $mTag) {
                    if ($mTag == '@主图') {
                        $guessList[$k]['logo'] = $mv['path'];
                    }
                }
            }
        }
    }
}
Tpl_Smarty::assign('_web_config', $webConfig);
Tpl_Smarty::assign('nav_index', empty($navIndex) ? 2 : $navIndex);
Tpl_Smarty::assign('_category_tree', $categoryTree);
Tpl_Smarty::assign('_category_info', $allCategory);
Tpl_Smarty::assign('top_category_id', $topCategoryId);
Tpl_Smarty::assign('parents', array_reverse($parents));
Tpl_Smarty::assign('category_id', $categoryId);
Tpl_Smarty::assign('list', $list);
Tpl_Smarty::assign('guess', $guessList);
Tpl_Smarty::assign('vendors', $vendors);
Tpl_Smarty::assign('filter_attr', $filterAttr);
Tpl_Smarty::assign('size_range', $size_range);
if (!empty($_REQUEST['request_devices']) && $_REQUEST['request_devices'] == 'mobile') {
    //手机页面加载更多
    Tpl_Smarty::display('Web', 'inc/service_list_body.tpl');

} else {
    Tpl_Smarty::display('Web', 'service-list.tpl');
}
